cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
# NOTE: 3.14 required for CPM, if not using it, 3.0.0 is probably okay

# Project name, version and languages
project(threadX_demo
    VERSION 6.0.0
    LANGUAGES C ASM
)

# Include helper modules
include(FeatureSummary)

# Set these to match your chip architecture and build toolchain
set(THREADX_ARCH "cortex_m4" CACHE STRING "")
set(THREADX_TOOLCHAIN "gnu" CACHE STRING "")

# Provide a custom tx_user.h file
set(TX_USER_FILE "${CMAKE_CURRENT_LIST_DIR}/app/inc/tx_user.h" CACHE STRING "")

# Define this target
add_executable(${PROJECT_NAME})

# Pick up the port specific variables
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/app)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/ports/${THREADX_ARCH}/${THREADX_TOOLCHAIN})

# Include threadX components from a local source dir (e.g. git submodule)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/threadx)
# add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/netx-duo)
# add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/filex)
# add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/usbx)

# The linker output should be .elf so we can keep track of it
set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".elf")

# Linker scripts
target_link_options(threadX INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?
target_link_options(${PROJECT_NAME} INTERFACE -T ${LINKER_SCRIPT})

# Link the demo with the RTOS lib and any other obj files provided by the port
# Must use the PUBLIC section since the dependencies are just pushing source to us
target_link_libraries(${PROJECT_NAME} PUBLIC threadX ${LINK_EXTRA_FILES})

# Custom command to copy the output file into a .BIN file
add_custom_command( TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMENT "Building .hex and .bin file"
)

# Dump a report of features turned on/off across all included libraries
feature_summary(WHAT ALL)