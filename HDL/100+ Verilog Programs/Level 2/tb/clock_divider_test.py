import os
from pathlib import Path

import cocotb
from cocotb.log import SimLog
from cocotb.log import logging
from cocotb.triggers import Timer, ClockCycles, RisingEdge
from cocotb.runner import get_runner
from cocotb.clock import Clock


@cocotb.test()
async def test_func(dut):
    cocotb.start_soon(Clock(dut.clk, 2, units="ns").start())
    log = SimLog("tb")
    logging.getLogger().setLevel(logging.INFO)
    log.warning("Set logging to DEBUG for details")
    dut.rst_.value = 0
    dut.en.value = 0
    log.debug(
        f"Pre  Reset await \t clk_out is {dut.clk_out.value.integer}   en {dut.en.value} rst {dut.rst_.value}")

    await Timer(2, units="ns")
    log.debug(
        f"Post Reset await \t clk_out is {dut.clk_out.value.integer}   en {dut.en.value} rst {dut.rst_.value}")
    dut.rst_.value = 1
    dut.en.value = 1
    log.debug(
        f"Post Reset await \t clk_out is {dut.clk_out.value.integer}   en {dut.en.value} rst {dut.rst_.value}")
    await Timer(2, "ns")
    case_per_div = 16
    tcase = 0
    for i in range(0, 8, 1):
        dut.div.value = i
        for j in range(0, case_per_div):
            time_value = (
                2 if i == 0 else
                4 if i == 1 else
                8 if i == 2 else
                16 if i == 3 else
                32 if i == 4 else
                64 if i == 5 else
                128 if i == 6 else
                256 if i == 7 else
                2)
            await ClockCycles(dut.clk, time_value, True)
            # await Timer(time_value*2, units="ns")
            log.debug(
                f"For div {i}\ttime_value {time_value}\ttcase {tcase}\tclk_out is {dut.clk_out.value.integer}\tExpected Clock out {1}\ten {dut.en.value} rst {dut.rst_.value}")
            assert dut.clk_out.value.integer == 1, f"For div {i}, time_value {time_value}, clk_out is {dut.clk_out.value.integer} Expected Clock out {1} , en {dut.en.value} rst {dut.rst_.value}"
            await ClockCycles(dut.clk, time_value, True)
            # await Timer(time_value*2, units="ns")
            assert dut.clk_out.value.integer == 0, f"For div {i}, time_value {time_value}, clk_out is {dut.clk_out.value.integer} Expected Clock out {0} , en {dut.en.value} rst {dut.rst_.value}"
            log.debug(
                f"For div {i}\ttime_value {time_value}\ttcase {tcase}\tclk_out is {dut.clk_out.value.integer}\tExpected Clock out {0}\ten {dut.en.value} rst {dut.rst_.value}")

            tcase += 1

    dut.log.info(f"Total cases (HIGH is one, LOW is one) : {tcase}")


def start_build():
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "verilator")
    proj_dir = Path(__file__).resolve().parent.parent
    verilog_sources = [proj_dir / "clock_divider.v"]

    runner = get_runner(sim)

    runner.build(
        hdl_toplevel="clock_divider",
        verilog_sources=verilog_sources,
        always=True
    )

    runner.test(
        hdl_toplevel="clock_divider", test_module="clock_divider_test"
    )


if __name__ == "__main__":
    start_build()
