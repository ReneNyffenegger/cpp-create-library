gcc -c -fPIC tq84.c -o tq84.o
gcc -c       main.c -o main.o

gcc -shared  tq84.o -o libtq84.so

# Note the order:
#   -ltq84 needs to be placed AFTER main.c
gcc -L.  main.c -ltq84 -o use-shared-object

#  If the shared object is in a non standard location, we
#  need to tell where it is via the LD_LIBRARY_PATH
#  environment variable
#
# ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory

LD_LIBRARY_PATH=$(pwd) ./use-shared-object

#  Removing the shared object so as to prove that it
#  is essential:
#  rm libtq84.so
#  LD_LIBRARY_PATH=$(pwd) ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory
