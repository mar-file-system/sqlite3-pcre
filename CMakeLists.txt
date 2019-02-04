cmake_minimum_required(VERSION 3.0.0)
project(sqlite3-pcre LANGUAGES C)

find_package(PkgConfig REQUIRED)

# search for sqlite3 installation
pkg_search_module(SQLITE3 REQUIRED sqlite3)
include_directories(AFTER SYSTEM ${SQLITE3_INCLUDE_DIRS}) # -Ipath/to/sqlite3/include
link_directories(${SQLITE3_LIBRARY_DIRS})                 # -Lpath/to/sqlite3/lib

# search for pcre installation
pkg_search_module(PCRE REQUIRED libpcre)
include_directories(AFTER SYSTEM ${PCRE_INCLUDE_DIRS})    # -Ipath/to/libpcre/include
link_directories(${PCRE_LIBRARY_DIRS})                    # -Lpath/to/libpcre/lib

# install the header
install(FILES pcre.h DESTINATION ${CMAKE_INSTALL_PREFIX})

# create the shared library file
add_library(shared SHARED pcre.c)
target_link_libraries(shared sqlite3 pcre)
set_target_properties(shared PROPERTIES OUTPUT_NAME "pcre")
install(TARGETS shared DESTINATION ${CMAKE_INSTALL_PREFIX})

# create the static library file
add_library(static STATIC pcre.c)
set_target_properties(static PROPERTIES COMPILE_FLAGS -DSQLITE_CORE)
target_link_libraries(static sqlite3 pcre)
set_target_properties(static PROPERTIES OUTPUT_NAME "pcre")
install(TARGETS static DESTINATION ${CMAKE_INSTALL_PREFIX})
