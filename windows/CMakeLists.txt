cmake_minimum_required(VERSION 3.14)
project(pixelcanvas LANGUAGES CXX)

set(BINARY_NAME "pixelcanvas")

set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")

add_subdirectory("${FLUTTER_MANAGED_DIR}")

add_executable("${BINARY_NAME}" WIN32
  "runner/main.cpp"
  "runner/utils.cpp"
  "runner/win32_window.cpp"
  "runner/flutter_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)

apply_standard_cpp_compiler_flags("${BINARY_NAME}")

target_link_libraries("${BINARY_NAME}" PRIVATE flutter flutter_wrapper_app)
