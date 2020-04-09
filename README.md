# Samples

This is a sample project that shows how to consume threadX in your own
MCU project.

This sample targets a Cortex-M4 MCU, using the ARM GCC toolchain to build.

## How to use

1. Clone this repository into your system
2. Ensure that the arm-none-eabi- tools are on your path
3. Run the rebuild.sh script in the project root
4. Your binary file will be generated into the $/build directory

## How to use threadX as a git submodule

1. Follow the steps 1-2 above
2. Add threadX as a git submodule with this command
   `git submodule add git@github.com:azurertos/threadx.git`
3. Edit the CMakeLists.txt file in the project root:
   * Comment out the CPMAddPackage block
   * Uncomment out the following add_subdirectory() section
4. Continue with 3-4 above