cmake_minimum_required(VERSION 3.13.0 FATAL_ERROR)

# See https://cmake.org/cmake/help/latest/policy/CMP0079.html for more info
cmake_policy(SET CMP0079 NEW)

# Project name, version and languages
project(threadX_demo
    VERSION 6.0.0
    LANGUAGES C ASM
)

# Include helper modules
include(FeatureSummary)

# Provide a custom tx_user.h file
set(TX_USER_FILE "${CMAKE_CURRENT_LIST_DIR}/app/inc/tx_user.h")
set(NX_USER_FILE "${CMAKE_CURRENT_LIST_DIR}/app/inc/nx_user.h")
set(FX_USER_FILE "${CMAKE_CURRENT_LIST_DIR}/app/inc/fx_user.h")
set(UX_USER_FILE "${CMAKE_CURRENT_LIST_DIR}/app/inc/ux_user.h")

# Define this target
add_executable(${PROJECT_NAME})

# Pick up the port specific variables
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/app)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/ports/${THREADX_ARCH}/${THREADX_TOOLCHAIN})

# Include threadX components from a local source dir (e.g. git submodule)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/threadx)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/netx-duo)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/filex)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/usbx)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/levelx)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/guix)

# The linker output should be .elf so we can keep track of it
set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".elf")

# Linker scripts
target_link_options(${PROJECT_NAME} INTERFACE -T ${LINKER_SCRIPT})
target_link_options(threadx INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?
target_link_options(netxduo INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?
target_link_options(filex INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?
target_link_options(usbx INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?
target_link_options(levelx INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?
target_link_options(guix INTERFACE -T ${LINKER_SCRIPT}) # Move this to the lib?

# Define inter-library dependencies (can we move these into the libs?)
target_link_libraries(guix INTERFACE threadx)
target_link_libraries(levelx INTERFACE threadx)
target_link_libraries(filex INTERFACE threadx)
target_link_libraries(netxduo INTERFACE filex threadx)
target_link_libraries(usbx INTERFACE netxduo threadx)

# Must use the PUBLIC section for the app target since the dependencies are
# just pushing source to us
target_link_libraries(${PROJECT_NAME} PUBLIC threadx filex netxduo usbx levelx)

# Custom command to copy the output file into a .BIN file
add_custom_command( TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMAND ${CMAKE_OBJCOPY} -I binary -O ihex ${PROJECT_NAME}.bin ${PROJECT_NAME}.hex
    COMMENT "Building .hex and .bin file"
)

# Dump a report of features turned on/off across all included libraries
feature_summary(WHAT ALL)