cmake_minimum_required(VERSION 3.16)
project(mir_kiosk_x11)
include(FindPkgConfig)

set(CMAKE_CXX_STANDARD 20)
pkg_check_modules(MIRAL miral REQUIRED)

add_executable(mir_kiosk_x11
        x11_kiosk_main.cpp
        x11_kiosk_window_manager.cpp x11_kiosk_window_manager.h
)

target_include_directories(mir_kiosk_x11 PUBLIC SYSTEM ${MIRAL_INCLUDE_DIRS})
target_link_libraries(mir_kiosk_x11 ${MIRAL_LDFLAGS})

install(PROGRAMS ${CMAKE_BINARY_DIR}/mir_kiosk_x11
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
)
