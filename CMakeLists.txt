cmake_minimum_required(VERSION 3.0.0)
project(sqlite3-pcre LANGUAGES C)

find_package(PkgConfig REQUIRED)

# search for sqlite3 installation
pkg_search_module(SQLITE3 REQUIRED sqlite3)
include_directories(AFTER SYSTEM ${SQLITE3_INCLUDE_DIRS}) # -Ipath/to/sqlite3/include
link_directories(${SQLITE3_LIBRARY_DIRS})                 # -Lpath/to/sqlite3/lib

# search for pcre installation
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/contrib")
pkg_search_module(PCRE REQUIRED libpcre)
include_directories(AFTER SYSTEM ${PCRE_INCLUDE_DIRS})    # -Ipath/to/libpcre/include
link_directories(${PCRE_LIBRARY_DIRS})                    # -Lpath/to/libpcre/lib

# create the shared object file
add_library(sqlite3-pcre SHARED pcre.c)
target_link_libraries(sqlite3-pcre sqlite3 pcre)
install(TARGETS sqlite3-pcre EXPORT DESTINATION lib)
set_target_properties(sqlite3-pcre PROPERTIES OUTPUT_NAME pcre)
