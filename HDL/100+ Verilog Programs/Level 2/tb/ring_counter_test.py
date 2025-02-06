import os
import sys
from pathlib import Path


import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.log import logging
from cocotb.runner import get_runner


@cocotb.test()
async def simple_test(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    dut.rst_.value = 0
    await Timer(10, units="ns")
    dut.rst_.value = 1
    dut.q._log.info(f"Initial value of 'q' after reset is :- {dut.q.value} ")
    for i in range(12):
        await Timer(10, units="ns")

        tb_val = 0b0001 << (i % 4)
        dut.q._log.info(
            f"Q :- 0b{dut.q.value.binstr} Expected :- {tb_val}")
        assert (dut.q.value.integer) == tb_val, f"Q :- 0b{
            dut.q.value.binstr} Expected :- {tb_val}"


def run_runner():
    hdl_toplevel_lang  = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "verilator")

    proj_dir = Path(__file__).resolve().parent.parent

    verilog_sources = [proj_dir / "ring_counter.v"]

    runner = get_runner(sim)

    runner.build(
        hdl_toplevel="ring_counter",
        verilog_sources=verilog_sources,
        always=True
    )

    runner.test(hdl_toplevel="ring_counter", test_module="ring_counter_test")


if (__name__ == "__main__"):
    run_runner()
