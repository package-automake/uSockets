
cmake_minimum_required(VERSION 3.13)
project(uSockets)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# build type
if(CMAKE_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Debug"))
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wall -O0")
add_definitions(-DDEBUG -D_DEBUG -DDEBUG_MODE)
message("Debug mode:${CMAKE_C_FLAGS_DEBUG}")
elseif(CMAKE_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Release"))
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Wall -O3")
add_definitions(-DNDEBUG -DRELEASE_MODE -DNDEBUG_MODE)
message("Release mode:${CMAKE_C_FLAGS_RELEASE}")
else()
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Wall -O3")
add_definitions(-DNDEBUG -DRELEASE_MODE -DNDEBUG_MODE)
message("else:${CMAKE_BUILD_TYPE}")
message("else:${CMAKE_C_FLAGS_RELEASE}")
endif()

# without ssl
add_definitions(-DLIBUS_NO_SSL)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

find_package(libuv REQUIRED)
if (NOT libuv_FOUND)
message(FATAL_ERROR "libuv Not Found!")
endif (NOT libuv_FOUND)

include_directories( ${PROJECT_SOURCE_DIR}/include )
include_directories( ${PROJECT_SOURCE_DIR}/ )
include_directories( "${PROJECT_SOURCE_DIR}/internal" )
include_directories( "${PROJECT_SOURCE_DIR}/internal/eventing")
include_directories( "${PROJECT_SOURCE_DIR}/internal/networking")
link_directories( ${PROJECT_SOURCE_DIR}/lib )

# add source files
# aux_source_directory( ${PROJECT_SOURCE_DIR} SourceList)
file(GLOB_RECURSE SRC_DIR_LIST "./*.cpp" "./*.c" "./*.cc")

# compile
add_library( ${PROJECT_NAME} STATIC ${SRC_DIR_LIST})
target_link_libraries( ${PROJECT_NAME} uv_a)
install(TARGETS ${PROJECT_NAME} ${PROJECT_NAME}
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        PUBLIC_HEADER DESTINATION include
        )
        
install(FILES ${PROJECT_SOURCE_DIR}/libusockets.h
        DESTINATION include
        )
