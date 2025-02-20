import os
from pathlib import Path
import random

import cocotb
from cocotb.triggers import Timer, RisingEdge, ClockCycles, ReadOnly, NextTimeStep, FallingEdge, Edge
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.log import SimLog, logging
from cocotb_bus.monitors import Monitor


class UART_TX_IN_Driver:
    def __init__(self, dut, name, clk, log):
        self.clk = clk
        self.dut = dut
        self.name = name
        self.log = log
        self.dut.trigger.value = 0

    async def _driver_send(self, value, sync=True):

        if self.dut.busy == 1:
            await FallingEdge(self.dut.busy)
        self.dut.trigger.value = 1
        await RisingEdge(self.clk)
        self.dut.trigger.value = 0
        self.log.info(f"Current Input for port [din] - {value}")
        self.dut.din.value = value
        await ClockCycles(self.dut.clk, 1041 * 8, rising=True)
        await ReadOnly()
        await NextTimeStep()


class tb_m:

    def __init__(self, dut, log):
        self.dut = dut
        self.log = log
        self.ip_vals = []
        self.ip_driv = UART_TX_IN_Driver(
            dut=self.dut, name="Din Input Driver", clk=self.dut.clk, log=self.log)

    async def reset(self):
        self.dut.rst_.value = 0
        await Timer(10, "ns")
        await RisingEdge(self.dut.clk)
        self.dut.rst_.value = 1
        await RisingEdge(self.dut.clk)

    async def ip_gen(self):
        for i in range(1):
            tmp = random.randint(0, 255)
            self.ip_vals.append(f"{tmp:08b}")
            await self.ip_driv._driver_send(tmp)

    def rasieResults(self):
        self.log.info(f"Input Values (binary):\n{self.ip_vals}")


class SigMon(Monitor):
    def __init__(self, clk, dut,  name, signal, log, callback=None, event=None):
        self.signal = signal
        self.clk = clk
        self.name = name
        self.dut = dut
        self.log = log
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        while True:
            await ClockCycles(self.clk, 1042)
            self._recv(self.signal.value.integer)


"""

class Monitor:
    def __init__(self, dut, log, signal):
        self.clk = dut.clk
        self.dut = dut
        self.log = log
        self.signal = signal
        self.running = False
        self.obs_val = []
        self.mon_han = None
        self.byteCap = 0

    def start(self):
        if self.running is False:
            self.running = True
            # Call the coroutine function to create a coroutine object
            self.mon_han = start_soon(self.mon())

    def stop(self):
        if self.running is True:
            self.running = False
            if self.mon_han:
                self.mon_han.kill()
            self.mon_han = None

    async def mon(self):
        while self.running is True:
            await ClockCycles(self.clk, 3)
            await RisingEdge(self.dut.busy)
            self.byteCap = 0
            while self.byteCap <= 10:

                await ReadOnly()
                self.obs_val.append(self.dut.dout.value.integer)
                self.log.info(f"Captured Value: {self.dut.dout.value.integer}")
                await ClockCycles(self.clk, 1042)
                self.byteCap += 1

    def results(self):
        self.log.debug(
            f"Received Values are :\n[Note : Account for 1 start bit and 1 stop bit]\n{self.obs_val}")

"""


def updateExp(transcation):
    global op_vals
    op_vals.append(transcation)


@cocotb.test()
async def tx_test(dut):
    log = SimLog("tb_log")
    global op_vals
    op_vals = []
    logging.getLogger(log.name).setLevel(logging.DEBUG)
    cocotb.start_soon(Clock(dut.clk, 100, "ns").start())

    mh = SigMon(dut.clk, dut, "Dout Mon", dut.dout, log, updateExp)
    log.info("START OF TEST")
    tb = tb_m(dut, log)
    log.info("RESET DUT")
    await tb.reset()
    await tb.ip_gen()

    await ClockCycles(dut.clk, 1041*4, rising=True)
    log.warning(
        "Note: first two values of below are idle [1], and start bit [0].")
    log.warning(
        "Account for the same for each transactionAccount for the same for each transaction")
    log.warning("Note: Transmission is LSB first")
    log.info(f"Expected values :\n{op_vals}")
    tb.rasieResults()
    cocotb.log.warning("FST Dump in sim_build/dump.fst")
    log.info("END OF TEST")


def start_build():
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "verilator")
    runner = get_runner(sim)

    # Make the path to the Verilog source file more flexible
    verilog_sources = [Path(__file__).resolve().parent.parent / "UART_Tx.v"]

    build_args = ["--trace", "--trace-fst", "--trace-structs"]
    runner.build(
        hdl_toplevel="UART_Tx",
        verilog_sources=verilog_sources,
        waves=True,
        build_args=build_args,
        always=True
    )

    runner.test(
        hdl_toplevel="UART_Tx",
        test_module="uart_tx_test",
        waves=True
    )


if __name__ == "__main__":
    start_build()
