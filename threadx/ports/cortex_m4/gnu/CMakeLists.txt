# This file sets arch and tool specific variables that get passed up to the
# parent CMakeLists via the PARENT_SCOPE argument passed to set()

# Linker script
# Note: You will need to change this file to match your specific MCU's memory layout
set(LINKER_SCRIPT 
    "${CMAKE_CURRENT_SOURCE_DIR}/STM32F407VGTx_FLASH.ld"
    PARENT_SCOPE
)

# Compiler options
set(COMPILE_OPTIONS
    --specs=nosys.specs 
    -fdata-sections 
    -ffunction-sections 
    -fstack-usage   
    -mcpu=cortex-m4 
    -mthumb 
    PARENT_SCOPE
)

# Linker options
set(LINK_OPTIONS
    LINKER:--gc-sections
    LINKER:-A,cortex-m4
    LINKER:-ereset_handler
    LINKER:-Map=${PROJECT_NAME}.map
    LINKER:-static
    PARENT_SCOPE
)

# Any additional object files (e.g. libc.a) that should be linked for this target
set(LINK_EXTRA_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/libc.a"
    PARENT_SCOPE
)