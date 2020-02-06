#include "cuda_hello_world/hello-world.h"
#include <string>

#include <cuda.h>
#include <cuda_runtime.h>

const int N = 7;
const int blocksize = 7;

static __global__ void hello(char *a, int *b) {
  a[threadIdx.x] += b[threadIdx.x];
}

std::string hello_world_cu() {
  char a[N] = "Hello ";
  int b[N] = {15, 10, 6, 0, -11, 1, 0};
  std::string result = std::string(a);

  char *ad;
  int *bd;
  const int csize = N*sizeof(char);
  const int isize = N*sizeof(int);

  cudaMalloc(reinterpret_cast<void**>(&ad), csize);
  cudaMalloc(reinterpret_cast<void**>(&bd), isize);
  cudaMemcpy(ad, a, csize, cudaMemcpyHostToDevice);
  cudaMemcpy(bd, b, isize, cudaMemcpyHostToDevice);

  dim3 dimBlock(blocksize, 1);
  dim3 dimGrid(1, 1);
  hello<<<dimGrid, dimBlock>>>(ad, bd);
  cudaMemcpy(a, ad, csize, cudaMemcpyDeviceToHost);
  cudaFree(ad);

  return result + std::string(a);
}
