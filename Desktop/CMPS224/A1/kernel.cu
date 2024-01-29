
#include "common.h"

#include "timer.h"

__global__ void vecMax_kernel(double* a, double* b, double* c, unsigned int M) {

    int i = blockDim.a*blockIdx.a + threadIdx.a;
	if(i < N) {
	    double aval = a[i];
        double bval = b[i];
        c[i] = (aval > bval)?aval:bval;
	}








}

void vecMax_gpu(double* a, double* b, double* c, unsigned int M) {

    Timer timer;

    // Allocate GPU memory
    startTime(&timer);

	float *a_d, *b_d, *c_d;
	cudaMalloc((void**) &a_d, M*sizeof(float));
	cudaMalloc((void**) &b_d, M*sizeof(float));
	cudaMalloc((void**) &c_d, M*sizeof(float));




    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Allocation time");

    // Copy data to GPU
    startTime(&timer);

	cudaMemcpy(a_d, x, M*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(b_d, y, M*sizeof(float), cudaMemcpyHostToDevice);


    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Copy to GPU time");

    // Call kernel
    startTime(&timer);

	vecMax_kernel(




    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Kernel time", GREEN);

    // Copy data from GPU
    startTime(&timer);

	cudaMemcpy(c, c_d, M*sizeof(float), cudaMemcpyDeviceToHost);


    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Copy from GPU time");

    // Free GPU memory
    startTime(&timer);

    cudaFree(a_d);
	cudaFree(b_d);
	cudaFree(c_d);


    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Deallocation time");

}

