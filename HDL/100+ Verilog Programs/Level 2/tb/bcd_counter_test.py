import os
import sys
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
    log.warning("Set Logging to DEBUG for additional information")
    logging.getLogger().setLevel(logging.INFO)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    dut.rst_.value = 0
    await RisingEdge(dut.clk)
    log.debug(f"Port bcd0 value after reset : {
        dut.bcd0.value} | Port bcd1 value after reset : {dut.bcd1.value}")
    dut.rst_.value = 1
    dut.d.value = 1
    tb_case = 0
    total_cases = 133
    for i in range(0, total_cases, 1):
        tb_case += 1
        await RisingEdge(dut.clk)
        log.debug(f"Passed :: bcd1 bcd0 {
            dut.bcd1.value.integer}{dut.bcd0.value.integer}, Expected {i % 100 // 10}{i % 10} | Pass/Total - {tb_case}/{total_cases}")
        assert dut.bcd0.value.integer == i % 10, f"Assertion Failed :: bcd1 bcd0 {
            dut.bcd1.value.integer}{dut.bcd0.value.integer}, Expected {i % 100 // 10}{i % 10} | Pass/Total - {tb_case}/{total_cases}"
        assert dut.bcd1.value.integer == ((i % 100) // 10), f"Assertion Failed :: bcd1 bcd0 {
            dut.bcd1.value.integer}{dut.bcd0.value.integer}, Expected {i % 100 // 10}{i % 10} | Pass/Total - {tb_case}/{total_cases}"
    log.info(f"Test cases Pass/Total - {tb_case}/{total_cases}")


def start_build():

    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")

    sim = os.getenv("SIM", "verilator")

    proj_dir = Path(__file__).resolve().parent.parent

    verilog_sources = [proj_dir / "bcd_counter.v"]

    runner = get_runner(sim)

    runner.build(
        hdl_toplevel="bcd_counter",
        verilog_sources=verilog_sources,
        always=True
    )

    runner.test(
        hdl_toplevel="bcd_counter",
        test_module="bcd_counter_test"
    )


if __name__ == ("__main__"):
    start_build()
