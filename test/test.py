# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

@cocotb.test()
async def test_all_modules(dut):
    dut._log.info("Starting test for all modules in tt_um_micro_tiles_container")

    # Set up the clock with a 10 us period (100 kHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Apply reset
    dut._log.info("Applying reset")
    dut.ena.value = 1  # Ignore as per top module, but set to 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1  # Release reset

    # Test all modules with different `ui_in` values
    for i in range(4):
        dut.uio_in.value = i  # Select the module using the `uio_in` selector
        dut._log.info(f"Activating module {i+1} with selector {i}")

        # Set distinct `ui_in` values depending on the module
        if i == 0:
            dut.ui_in.value = 0  # For proj1, `ui_in` is 0 by default in the module
        elif i == 1:
            dut.ui_in.value = 0b00000001  # Trigger `uo_out_proj[1]` from proj2 with a single bit change
        elif i == 2:
            dut.ui_in.value = 0b00000110  # Test proj3 with specific bits set
        elif i == 3:
            dut.ui_in.value = 0b00011000  # Test proj4 with different bits set

        # Allow the module some clock cycles to process
        await ClockCycles(dut.clk, 10)

        # Check the output for each selected module
        output_val = dut.uo_out.value
        dut._log.info(f"Output from module {i+1} (selector {i}): {output_val}")

        # Here, you could add assertions based on expected behavior for each module
        # e.g., assert output_val == expected_val, "Output mismatch for module {i+1}"

    dut._log.info("Test complete for all modules")

