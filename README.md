![Samples Build CI](https://github.com/azurertos/samples/workflows/Samples%20Build%20CI/badge.svg)

# Samples

This is a sample project that shows how to use threadX in your own MCU project.

This sample targets a Cortex-M4 MCU, using the ARM GCC toolchain to build.

# Usage

Before you can build and flash this sample to a real device, you may  need to make a few changes:

1. Choose the correct linker script for your board. A few different Cortex-M4 starter scripts are provided in ports/cortex_m4/gnu. You will need to update the CMakeLists file in that directory as required for your hardware.

2. Update the vector table as required. The vector table, which in this sample lives in the assembly language file ports/cortex_m4/gnu/tx_vector_table.S, contains the various entry points and interrupt handlers used by your app.