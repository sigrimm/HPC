#include <stdio.h>
#include <stdlib.h>
#include <chrono>





__global__ void addTest_kernel(double *a_d, double *b_d, double *c_d, const int N){

	int id = threadIdx.x * blockDim.x + blockIdx.x;

	if(id < N){
		for(int t = 0; t < 10000000; ++t){
			c_d[id] += a_d[id] + b_d[id];
		}
	}
}


int main(){

	int N = 100;

	double *a_h, *b_h, *c_h;
	double *a_d, *b_d, *c_d;


	cudaEvent_t tt1, tt2;
	float times;

	a_h = (double*)malloc(N * sizeof(double));
	b_h = (double*)malloc(N * sizeof(double));
	c_h = (double*)malloc(N * sizeof(double));


	cudaMalloc((void **) &a_d, N * sizeof(double));
	cudaMalloc((void **) &b_d, N * sizeof(double));
	cudaMalloc((void **) &c_d, N * sizeof(double));

	for(int i = 0; i < N; ++i){
		a_h[i] = 0.1;
		b_h[i] = 100.0;
		c_h[i] = 0.0;
	}

	cudaMemcpy(a_d, a_h, N * sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(b_d, b_h, N * sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(c_d, c_h, N * sizeof(double), cudaMemcpyHostToDevice);


	cudaEventCreate(&tt1);
	cudaEventCreate(&tt2);

	cudaEventRecord(tt1, 0);

	addTest_kernel <<< (N + 127) / 128, 128 >>>(a_d, b_d, c_d, N);

	cudaEventRecord(tt2, 0);
	cudaEventSynchronize(tt2);
	cudaEventElapsedTime(&times, tt1, tt2);

	cudaMemcpy(c_h, c_d, N * sizeof(double), cudaMemcpyDeviceToHost);

	printf("Time in seconds:  %.8g\n", times * 0.001);

	//for(int i = 0; i < N; ++i){
	//	printf("%d %g\n", i, c_h[i]);
	//}


	return 0;
}
