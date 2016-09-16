cmake_minimum_required(VERSION 3.4 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core REQUIRED)
file(GLOB SOURCES *.cpp)
add_library(qoauthlogin SHARED ${SOURCES})
target_include_directories(qoauthlogin PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
qt5_use_modules(qoauthlogin Core)
