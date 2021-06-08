cmake_minimum_required (VERSION 2.8)
project(cuda_hello_world_catkin)
set(CMAKE_CUDA_COMPILER  /usr/local/cuda/bin/nvcc)

find_package(CUDA REQUIRED)
find_package(catkin_simple REQUIRED)
catkin_simple(ALL_DEPS_REQUIRED)

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++14" COMPILER_SUPPORTS_CXX14)
if(COMPILER_SUPPORTS_CXX14)
 set(CMAKE_CXX_STANDARD 14)
 set(CMAKE_CXX_FLAGS         "-Wall -Wextra -msse -msse2 -msse3 -msse4 -O3 -DNDEBUG")
 set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g")
 set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
else()
 message(FATAL_ERROR "The compiler does not support C++14.")
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

cuda_add_library(${PROJECT_NAME}_cuda_lib
  src/hello-world.cu
)
cs_add_library(${PROJECT_NAME}_lib
  src/hello-world-node.cc
)

cuda_add_executable(${PROJECT_NAME}_cuda app/cuda-hello-world-app.cc)

target_link_libraries(${PROJECT_NAME}_cuda ${PROJECT_NAME}_lib ${PROJECT_NAME}_cuda_lib ${CUDA_LIBRARIES})

#############
## TESTING ##
#############

# Sanity check.
catkin_add_gtest(test_sanity_check test/sanity-check/sanity-check-test.cc)
target_link_libraries(test_sanity_check ${PROJECT_NAME}_lib)

cs_install()
cs_export()
