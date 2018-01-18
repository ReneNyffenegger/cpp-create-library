gcc -c       tq84.c -o tq84.o
gcc -c       main.c -o main.o

gcc -shared  tq84.o -o libtq84.dll

# Note the order:
#   -ltq84 needs to be placed AFTER main.c
gcc -L.  main.c -ltq84 -o use-shared-object

.\use-shared-object

del libtq84.dll
