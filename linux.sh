gcc -c -fPIC tq84.c -o tq84-PIC.o
gcc -c       tq84.c -o tq84.o

objdump --disassemble tq84-PIC.o
objdump --disassemble tq84.o

readelf --relocs tq84-PIC.o
readelf --relocs tq84.o

gcc -c       main.c -o main.o

gcc -shared  tq84.o -o libtq84.so
#
#    /usr/bin/ld: tq84.o: relocation R_X86_64_PC32 against symbol `gSummand' can not be used when making a shared object; recompile with -fPIC
#
gcc -shared  tq84-PIC.o -o libtq84.so


# Note the order:
#   -ltq84 needs to be placed AFTER main.c
gcc -L.  main.c -ltq84 -o use-shared-object


#
#  show required shared libraries of an executable
#
ldd ./use-shared-object

#  If the shared object is in a non standard location, we
#  need to tell where it is via the LD_LIBRARY_PATH
#  environment variable
#
# ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory

LD_LIBRARY_PATH=$(pwd) ./use-shared-object

sudo mv libtq84.so /usr/lib
sudo chmod 755 /usr/lib/libtq84.so
./use-shared-object

#
#  Use LD_DEBUG
#    set it to libs to display library search paths
#
LD_LIBRARY_PATH=$(pwd) LD_DEBUG=libs ./use-shared-object

#
#  Setting LD_DEBUG to files to display progress for input files
#
LD_LIBRARY_PATH=$(pwd) LD_DEBUG=files ./use-shared-object

#
#  Setting LD_DEBUG to reloc to display relocation processing
#
LD_LIBRARY_PATH=$(pwd) LD_DEBUG=reloc ./use-shared-object

LD_LIBRARY_PATH=$(pwd) LD_DEBUG=symbols ./use-shared-object

#  Removing the shared object so as to prove that it
#  is essential:
#  rm libtq84.so
#  LD_LIBRARY_PATH=$(pwd) ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory


#

gcc tq84.o     main.o -o statically-linked
gcc tq84-PIC.o main.o -o statically-linked-PIC


#
# Using dl functions
#
gcc dlopen.c -ldl -o dlopen
LD_LIBRARY_PATH=$(pwd) ./dlopen

# Using sonames
 gcc -shared  tq84-PIC.o -Wl,-soname,libtq84.so.1 -o libtq84.so.1.0.1
