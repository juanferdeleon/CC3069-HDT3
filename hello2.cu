/*
 ============================================================================
 Author        : G. Barlas
 Version       : 1.0
 Last modified : December 2014
 License       : Released under the GNU GPL 3.0
 Description   : 
 To build use  : nvcc hello2.cu -o hello2 -arch=sm_20 
 ============================================================================
 */
#include <stdio.h>
#include <cuda.h>

__global__ void hello ()
{
  int myIDnw = ( blockIdx.z * gridDim.x * gridDim.y  + 
               blockIdx.y * gridDim.x + 
               blockIdx.x ) * blockDim.x * blockDim.y * blockDim.z + 
               threadIdx.z *  blockDim.x * blockDim.y + 
               threadIdx.y * blockDim.x + 
               threadIdx.x; 

  // Simplification of above 
  int myID = ( blockIdx.z * gridDim.x * gridDim.y  + 
               blockIdx.y * gridDim.x + 
               blockIdx.x ) * blockDim.x + 
               threadIdx.x; 

  printf ("Hello world from %i\n", myIDnw);
}

int main ()
{
  // dim3 g (4, 3, 2);
  // hello <<< g, 10 >>> ();
  // dim3 g (4,2);
  // dim3 b (32,16);
  dim3 g (8,128);
  dim3 b (16,8);
  hello <<<g, b>>>();
  cudaThreadSynchronize ();
  return 0;
}
