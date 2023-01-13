set(HEADERS
    FilePickerViewModel.hpp
)

target_sources(${PROJECT_NAME}
    PRIVATE
        ${HEADERS}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/product>
)
