target_sources(${PROJECT_NAME}
    PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/inc/tx_user.h
    ${CMAKE_CURRENT_LIST_DIR}/src/demo_threadx.c
)

target_include_directories(${PROJECT_NAME}
    PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/inc
)