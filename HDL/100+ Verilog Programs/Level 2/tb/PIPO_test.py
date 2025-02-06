import os
import sys
from pathlib import Path


import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.runner import get_runner


@cocotb.test()
async def simple_pipo(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    cocotb.log.debug("Starting Test - simple_pipo")
    dut.d.value = 0
    dut.rst_.value = 1
    dut.so._log.info("Initial so value %s" % dut.so.value.binstr)
    await Timer(10, units="ns")
    for i in range(10):
        dut.d.value = i
        await Timer(10, units="ns")
        so_Value = dut.so.value
        assert int(so_Value.integer) == i, f"-- dut.so.value was {
            so_Value.binstr}  Expected {i} "
        dut.so._log.info(
            f"serial out [port : so] :- {so_Value.binstr} for d :- {i}")


def run_runner():
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "verilator")

    proj_path = Path(__file__).resolve().parent.parent

    print("-- Project path : %s " % proj_path)

    verilog_sources = [proj_path / "PIPO.v"]

    print("-- Verilog Sources : %s" % verilog_sources)

    runner = get_runner(sim)

    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel="PIPO",
        always=True
    )

    runner.test(hdl_toplevel="PIPO", test_module="PIPO_test")


if __name__ == "__main__":
    run_runner()
