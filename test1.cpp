#include <stdio.h>
#include <stdlib.h>





void addTest(double *a, double *b, double *c, const int N){

  for(int i = 0; i < N; ++i){
    c[i] = a[i] + b[i];
  }
}


int main(){

  int N = 100;

  double *a, *b, *c;


  a = (double*)malloc(N * sizeof(double));
  b = (double*)malloc(N * sizeof(double));
  c = (double*)malloc(N * sizeof(double));

  for(int i = 0; i < N; ++i){
    a[i] = 0.1;
    b[i] = 100.0;
    c[i] = 0.0;
  }

  addTest(a, b, c, N);

  for(int i = 0; i < N; ++i){
    printf("%d %g\n", i, c[i]);
  }


  return 0;
}
