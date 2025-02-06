import os
import sys
from pathlib import Path

import cocotb
from cocotb.log import SimLog
from cocotb.log import logging
from cocotb.triggers import RisingEdge
from cocotb.runner import get_runner
from cocotb.clock import Clock


@cocotb.test()
async def test_func(dut):
    cocotb.start_soon(Clock(dut.clk, 1, units="ns"))
    log = SimLog("tb")
    logging.getLogger().setLevel(logging.DEBUG)
    log.warning("Set logging to DEBUG for details")
    dut.rst_.value = 0


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
