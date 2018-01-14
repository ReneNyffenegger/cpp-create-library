gcc -c     tq84.c -o tq84.o

ar  rcs libtq84.a    tq84.o

gcc -shared -Wl,-soname,libtq84.so.1 -o libtq84.so.1.0.1 tq84.o

gcc -c main.c -o main.o

gcc main.o -o dynamically-linked -L. -ltq84

gcc -static main.o -L. -ltq84 -o statically-linked
