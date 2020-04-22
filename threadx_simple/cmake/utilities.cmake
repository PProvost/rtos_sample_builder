# TODO - this should take variable arguments so the user only has
#        to provide the targetname if they need to
function(add_azrtos_component_dir dirname targetname)
    set(tmp ${azrtos_targets})
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/${dirname})
    if(${LINKER_SCRIPT})
        target_link_options(${targetname} INTERFACE -T ${LINKER_SCRIPT})
    endif()
    list(APPEND tmp ${targetname})
    set(azrtos_targets ${tmp} PARENT_SCOPE)
endfunction()