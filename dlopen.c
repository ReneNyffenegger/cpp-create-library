#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
// #include "tq84.h"

int main(int argc, char* argv[]) {

    double v1, v2, m;

 //
 // Declare the function pointer
    double (*func_ptr)(double, double);

    v1 = 5.2;
    v2 = 7.9;

 //
 // Open the dynamic library
    void* tq84_lib = dlopen("libtq84.so",  RTLD_LAZY | RTLD_GLOBAL);

    if (!tq84_lib) {
     //
     // Apparently, the library could not be opened
        fprintf(stderr, "Could not open libtq84.so\n");
        exit(1);
    }

 //
 // Get the function pointer to the function
    func_ptr = dlsym(tq84_lib, "mean");
    if (!func_ptr) {
      fprintf(stderr, "Could not get function pointer for mean\n");
      exit(1);
    }

 //
 // Call the function via the function pointer
    m = func_ptr(v1, v2);

    printf("The mean of %3.2f and %3.2f is %3.2f\n", v1, v2, m);

}
