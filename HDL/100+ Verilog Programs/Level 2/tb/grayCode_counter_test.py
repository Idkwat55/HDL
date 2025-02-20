import os
from pathlib import Path

import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.log import logging
from cocotb.log import SimLog


@cocotb.test()
async def test_func(dut):
    log = SimLog("TESTBENCH")
    logging.getLogger().setLevel(logging.INFO)
    log.warning("Set Logging to DEBUG for more information")
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    dut.rst_.value = 0
    await RisingEdge(dut.clk)
    log.debug(f"Port count value after reset : {
        dut.count.value} | Reg bin_count value after reset : {dut.bin_count.value}")
    dut.rst_.value = 1
    dut.d.value = 1
    tb_case = 0
    total_cases = 24
    for i in range(0, total_cases, 1):
        tb_case += 1
        await RisingEdge(dut.clk)
        log.debug(f"count : 0b{dut.count.value.binstr}, Expected : 0b{
                  i % 16 ^ (i % 16 >> 1):04b} Pass/Total - {tb_case:2d}/{total_cases:2d}")
        assert dut.count.value.integer == (i % 16 ^ (i % 16 >> 1)), f" Port count is 0b{
            dut.count.value.bin}, Expected 0b{i % 16 ^ (i % 16 >> 1):04b}"
    log.info(f"Test cases Pass/Total - {tb_case}/{total_cases}")


def start_build():

    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")

    sim = os.getenv("SIM", "verilator")

    proj_dir = Path(__file__).resolve().parent.parent

    verilog_sources = [proj_dir / "grayCode_counter.v"]

    runner = get_runner(sim)

    runner.build(
        hdl_toplevel="grayCode_counter",
        verilog_sources=verilog_sources,
        always=True
    )

    runner.test(
        hdl_toplevel="grayCode_counter",
        test_module="grayCode_counter_test"
    )


if __name__ == ("__main__"):
    start_build()
