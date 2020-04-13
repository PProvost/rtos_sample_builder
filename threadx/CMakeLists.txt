cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
# NOTE: 3.13.5 req'd for add_link_options, 3.14 required for CPM

include(FeatureSummary)

# Set these to match your chip architecture and build toolchain
set(THREADX_ARCH "cortex_m4" CACHE STRING "")
set(THREADX_TOOLCHAIN "gnu" CACHE STRING "")

# Provide a custom tx_user.h file
set(TX_USER_FILE "${CMAKE_CURRENT_LIST_DIR}/app/inc/tx_user.h" CACHE STRING "")

project(threadX_demo
    VERSION 6.0.0
    LANGUAGES C ASM
)

# Add the demo source files
set(APP_SOURCES
    app/src/demo_threadx.c
)

# Pick up the port specific variables
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/ports/${THREADX_ARCH}/${THREADX_TOOLCHAIN}")

# And the compile/linker options specified in the port's CMakeLists.txt (must come before
#  the targets are defined)
add_compile_options(${COMPILE_OPTIONS})
add_link_options(${LINK_OPTIONS})

# Tell CMake we're making an executable
add_executable(${PROJECT_NAME})

# The linker output should be .elf so we can keep track of it
set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".elf")

# Option 1 - Include threadX dynamically at build configuration time
include(cmake/CPM.cmake)
CPMAddPackage(
    NAME threadX_lib
    GIT_REPOSITORY git@github.com:azurertos/threadx.git
    GIT_TAG master
)

include(cmake/CPM.cmake)
CPMAddPackage(
    NAME netxduo_lib
    GIT_REPOSITORY git@github.com:azurertos/netx-duo.git
    GIT_TAG master
)

include(cmake/CPM.cmake)
CPMAddPackage(
    NAME usbx_lib
    GIT_REPOSITORY git@github.com:azurertos/usbx.git
    GIT_TAG master
)

# Option 2 - Include threadX from a local source dir (e.g. git submodule)
# add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/threadx)

# Add the sources
target_sources(${PROJECT_NAME}
    PRIVATE
        ${PORT_SOURCES}
        ${APP_SOURCES}
)

# And use the provided linker script on the targets
target_link_options(threadX_lib INTERFACE -T ${LINKER_SCRIPT})
target_link_options(${PROJECT_NAME} INTERFACE -T ${LINKER_SCRIPT})

# Link the demo with the RTOS lib and any other obj files provided by the port
target_link_libraries(threadX_demo PRIVATE threadX_lib ${LINK_EXTRA_FILES})

# Custom command to copy the output file into a .BIN file
add_custom_command(
    TARGET ${PROJECT_NAME}
    POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
)

feature_summary(WHAT ALL)