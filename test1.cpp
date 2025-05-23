#include <stdio.h>
#include <stdlib.h>
#include <chrono>





void addTest(double *a, double *b, double *c, const int N, double t, int &time){

	std::chrono::steady_clock::time_point time_begin = std::chrono::steady_clock::now();

	for(int i = 0; i < N; ++i){
		c[i] += a[i] * t + 1.5 * t * b[i] + 0.8 * t * t;
	}
        std::chrono::steady_clock::time_point time_end = std::chrono::steady_clock::now();
        time += std::chrono::duration_cast<std::chrono::microseconds>(time_end - time_begin).count();
}


int main(){

	int N = 500000;
	int time = 0;

	double *a, *b, *c;


	a = (double*)malloc(N * sizeof(double));
	b = (double*)malloc(N * sizeof(double));
	c = (double*)malloc(N * sizeof(double));

	for(int i = 0; i < N; ++i){
		a[i] = 0.1;
		b[i] = 100.0;
		c[i] = 0.0;
	}

	addTest(a, b, c, N, 1.5, time);


	printf("Time in seconds:  %.8g\n", time / 1000000.0);

	//for(int i = 0; i < N; ++i){
	//	printf("%d %g\n", i, c[i]);
	//}


	return 0;
}
