
/*************************************************************************
* Axpy Kernel
* Author: Jesus Labarta
* Barcelona Supercomputing Center
*************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <assert.h>
#include "utils.h" 

#include "../../common/riscv_util.h"

#ifdef USE_SYCL
#include <sycl/sycl.hpp>
void axpy_serial_sycl(sycl::queue& q, double a, double *dx, double *dy, int n) {
   int i;
   q.submit([&](sycl::handler& cgh) {
      cgh.parallel_for(sycl::range<1>(n), [=](sycl::id<1> i) {
         dy[i] += a*dx[i];
      });
   }).wait();
}
#endif

/*************************************************************************/

#ifndef USE_RISCV_VECTOR
    void axpy_serial(double a, double *dx, double *dy, int n); 
#else
    void axpy_vector(double a, double *dx, double *dy, int n); 
#endif

int main(int argc, char *argv[])
{
    long long start,end;
    start = get_time();
    long n;

    if (argc == 2)
    n = 1024*atol(argv[1]); // input argument: vector size in Ks
    else
        n = (30*1024);


    #ifdef USE_SYCL
        sycl::queue q(sycl::cpu_selector_v);
        double *dx = sycl::malloc_shared<double>(n, q);
        double *dy = sycl::malloc_shared<double>(n, q);
    #else
        /* Allocate the source and result vectors */
        double *dx     = (double*)malloc(n*sizeof(double));
        double *dy     = (double*)malloc(n*sizeof(double));
    #endif


    double a=1.53;
    init_vector(dx, n, 1.83);
    init_vector(dy, n, 2.22);
    
    double reference = capture_ref_result(a, dx, dy, n);

    end = get_time();
    printf("init_vector time: %f\n", elapsed_time(start, end, false));

    start = get_time();
#ifndef USE_RISCV_VECTOR
    #ifdef USE_SYCL
        axpy_serial_sycl(q, a, dx, dy, n);
    #else
        axpy_serial(a, dx, dy, n);
    #endif
#else
    axpy_vector(a, dx, dy, n);
#endif

    end = get_time();
    printf("axpy time: %f\n", elapsed_time(start, end, true));

    printf ("done\n");
    test_result(dy, reference, n);

    free(dx); free(dy);
    return 0;
}
