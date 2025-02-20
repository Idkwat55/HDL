import os
from pathlib import Path

import cocotb
import cocotb.clock
from cocotb.triggers import Timer, ReadOnly, ReadWrite
from cocotb.log import SimLog, logging
from cocotb.runner import get_runner

import random


class Multiplier_test:
    def __init__(self, dut, logObject, name="Multiplier Module Test Class"):
        if (dut is None):
            raise ValueError("DUT Value must be suplied")
        if (logObject is None):
            raise ValueError("Log object is needed for logging")
        self.name = name
        self.a = 0
        self.b = 0
        self.dut = dut
        self.log = logObject
        self.Directed_running = False
        self.Randomized_running = False
        self.DirectedCases = 0
        self.RandomizedCases = 0

    def __repr__(self):
        self.log.info(
            f"You are Inside {self.name}, with dut {self.dut}, and log {self.log}")
        pass

    def model(self, a=0, b=0):
        return a * b

    async def restoreDUT(self):
        self.dut.a.value = 0
        self.dut.b.value = 0
        await Timer(1, "ns")
        self.log.warning("DUT restored")
        self.log.warning(
            f"a {self.dut.a.value.integer:8d}\tb {self.dut.b.value.integer:8d}\tp {self.dut.p.value.integer:8d}")

    async def start_Directed(self):
        self.log.info("start_Directed() Called")
        if self.Directed_running is not True:
            self.Directed_running = True
            await self.Directed()
        else:
            self.log.warning("Test is already runnning!")

    def stop_Directed(self):
        if self.Directed_running is not False:
            self.Directed_running = False
        else:
            self.log.warning("Tests were never started!")

    async def start_Randomized(self, maxCases):
        self.log.info("start_Randomized() Called")
        if self.Randomized_running is not True:
            self.Randomized_running = True
            await self.Randomized(maxCases)
        else:
            self.log.warning("Test is already runnning!")

    def stop_Randomized(self):
        if self.Randomized_running is not False:
            self.Randomized_running = False
        else:
            self.log.warning("Tests were never started!")

    async def Directed(self):
        self.log.debug("Directed() Called")
        await self.restoreDUT()
        if (self.Directed_running):
            driv_a = (15, 0xff, 0x00, 0x2a, 0x15, 0x81)
            driv_b = (4, 0xff, 0x00, 0x2a, 0x15, 0x81)
            for x in driv_a:
                for y in driv_b:
                    self.dut.a.value = x
                    self.dut.b.value = y
                    await Timer(1, "ns")
                    self.log.debug(f"a {x:8d}\tb {y:8d}\texpected\t{self.model(
                        x, y):8d}\tGot {self.dut.p.value.integer:8d}")
                    assert self.dut.p.value.integer == self.model(
                        x, y), "[Directed] Failed to Match with Reference Model"
                    self.DirectedCases += 1
            self.stop_Directed()

    async def Randomized(self, maxCases):
        self.log.debug("Randomized() Called")
        await self.restoreDUT()
        while (self.RandomizedCases < maxCases):
            x, y = (random.randint(0, 255), random.randint(0, 255))
            self.dut.a.value = x
            self.dut.b.value = y
            await Timer(1, "ns")
            self.log.debug(
                f"a {x:8d}\tb {y:8d}\texpected\t{self.model(x, y):8d}\tGot {self.dut.p.value.integer:8d}")
            assert self.dut.p.value.integer == self.model(
                x, y), "[Randomized] Failed to Match with Reference Model"
            self.RandomizedCases += 1

    def reportCases(self):
        self.log.info(f"Directed cases : {self.DirectedCases}")
        self.log.info(f"Randomized cases : {self.RandomizedCases}")
        self.log.info(
            f"Total cases : {self.DirectedCases + self.RandomizedCases}")


@cocotb.test()
async def Test_Mult(dut):
    log = SimLog("tb")
    logging.getLogger().setLevel(logging.INFO)

    await Timer(1, "ns")
    tester = Multiplier_test(dut, log)
    await tester.start_Directed()
    await tester.start_Randomized(36)
    tester.reportCases()


def start_build():
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")

    sim = os.getenv("SIM", "verilator")

    proj_dir = Path(__file__).resolve().parent.parent

    verilog_sources = [proj_dir / "SA_mult.v"]

    runner = get_runner(sim)

    build_args = ["--trace", "--trace-fst", "--trace-structs"]

    runner.build(
        hdl_toplevel="SA_mult",
        verilog_sources=verilog_sources,
        waves=True,
        build_args=build_args,
        always=True
    )

    runner.test(
        hdl_toplevel="SA_mult",
        test_module="sa_mult_test",
        waves=True
    )


if __name__ == "__main__":
    start_build()
