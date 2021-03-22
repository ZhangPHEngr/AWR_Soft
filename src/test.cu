#include <stdio.h>
#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "test.h"

__global__ void addKernel(int* dev_c, int* dev_a, int* dev_b){

    int index = threadIdx.x;
    dev_c[index] = dev_a[index] + dev_b[index];

}

 int func(){
    const int N = 5;
    int a[N] = {1,2,3,4,5};
    int b[N] = {10,11,12,13,14};
    int c[N];

    int* dev_a; cudaMalloc((void**)&dev_a, N*sizeof(int));
    int* dev_b; cudaMalloc((void**)&dev_b, N*sizeof(int));
    int* dev_c; cudaMalloc((void**)&dev_c, N*sizeof(int));

    cudaMemcpy(dev_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N*sizeof(int), cudaMemcpyHostToDevice);

    addKernel<<<1, N>>>(dev_c, dev_a, dev_b);


    cudaMemcpy(c, dev_c, N*sizeof(int), cudaMemcpyDeviceToHost);

    for(int i = 0; i<N; i++){
        printf("%d\n",c[i]);
    }
    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_c);
}
