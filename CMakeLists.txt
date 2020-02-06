cmake_minimum_required (VERSION 2.8)
project(cuda_hello_world_catkin)
set(CMAKE_CUDA_COMPILER  /usr/local/cuda/bin/nvcc)


find_package(CUDA REQUIRED)
find_package(catkin_simple REQUIRED)
catkin_simple(ALL_DEPS_REQUIRED)



cs_install()
cs_export()
