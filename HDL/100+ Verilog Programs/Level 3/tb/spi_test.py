import os
from pathlib import Path
import random

import cocotb
from cocotb.triggers import Timer, RisingEdge, ClockCycles, ReadOnly, NextTimeStep, FallingEdge, Edge
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.log import SimLog, logging
from cocotb_bus.monitors import Monitor


class SigMon(Monitor):
    def __init__(self, clk,  name, signal, callback=None, event=None):
        self.signal = signal
        self.clk = clk
        self.name = name
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        while True:
            await RisingEdge(self.clk)
            self._recv(self.signal.value.integer)


class TB:
    def __init__(self, dut, log):
        self.clk = dut.clk
        self.dut = dut
        self.log = log


def start_build():
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "verilator")
    runner = get_runner(sim)

    # Make the path to the Verilog source file more flexible
    verilog_sources = [Path(__file__).resolve().parent.parent / "spi.v"]

    build_args = ["--trace", "--trace-fst", "--trace-structs"]
    runner.build(
        hdl_toplevel="spi_master",
        verilog_sources=verilog_sources,
        waves=True,
        build_args=build_args,
        always=True
    )

    runner.test(
        hdl_toplevel="spi_master",
        test_module="spi_test",
        waves=True
    )


if __name__ == "__main__":
    start_build()
