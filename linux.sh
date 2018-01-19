gcc -c -fPIC tq84.c -o bin/tq84-PIC.o
gcc -c       tq84.c -o bin/tq84.o

objdump --disassemble tq84-PIC.o
objdump --disassemble tq84.o

readelf --relocs tq84-PIC.o
readelf --relocs tq84.o

gcc -c       main.c -o bin/main.o

gcc -shared  bin/tq84.o -o bin/libtq84.so
#
#    /usr/bin/ld: bin/tq84.o: relocation R_X86_64_PC32 against symbol `gSummand' can not be used when making a shared object; recompile with -fPIC
#
gcc -shared  bin/tq84-PIC.o -o bin/libtq84.so


# Note the order:
#   -ltq84 needs to be placed AFTER main.c
gcc -Lbin  bin/main.c -ltq84 -o bin/use-shared-object


#
#  show required shared libraries of an executable
#
ldd bin/use-shared-object

#  If the shared object is in a non standard location, we
#  need to tell where it is via the LD_LIBRARY_PATH
#  environment variable
#
# ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory

LD_LIBRARY_PATH=$(pwd)/bin bin/use-shared-object

#
#   Moving the shared object to a standard location
#
sudo mv bin/libtq84.so /usr/lib
sudo chmod 755 /usr/lib/libtq84.so

#
#  After moving the shared object to /usr/lib, the executable
#  can be executed without specifying LD_LIBRARY_PATH
#
bin/use-shared-object

#
#  Use LD_DEBUG
#    set it to libs to display library search paths
#
LD_LIBRARY_PATH=$(pwd)/bin LD_DEBUG=libs bin/use-shared-object

#
#  Setting LD_DEBUG to files to display progress for input files
#
LD_LIBRARY_PATH=$(pwd)/bin LD_DEBUG=files bin/use-shared-object

#
#  Setting LD_DEBUG to reloc to display relocation processing
#
LD_LIBRARY_PATH=$(pwd)/bin LD_DEBUG=reloc bin/use-shared-object

LD_LIBRARY_PATH=$(pwd)/bin LD_DEBUG=symbols bin/use-shared-object

#  Removing the shared object so as to prove that it
#  is essential:
#  rm libtq84.so
#  LD_LIBRARY_PATH=$(pwd) ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory


#

gcc bin/tq84.o     bin/main.o -o bin/statically-linked
gcc bin/tq84-PIC.o bin/main.o -o bin/statically-linked-PIC


#
# Using dl functions
#
gcc dlopen.c -ldl -o bin/dlopen

#
#  As long as /usr/lib/libtq84.so exists, LD_LIBRARY_PATH
#  needs not be set
#
bin/dlopen
LD_LIBRARY_PATH=$(pwd) bin/dlopen

#
#  Using sonames
#
gcc -shared  bin/tq84-PIC.o -Wl,-soname,libtq84Soname.so.1 -o bin/libtq84Soname.so.1.0.1
gcc -Lbin   main.c -ltq84Soname -o bin/use-shared-library-soname

ln -s libtq84Soname.so.1.0.1 bin/libtq84Soname.so
gcc -Lbin   main.c -ltq84Soname -o bin/use-shared-library-soname



#
#  Installing the library
#
sudo cp bin/libtq84Soname.so.1.0.1 /usr/lib
sudo ldconfig -v -n /usr/lib

#
#   ldconfig created a symbolic link from /usr/lib/libtq84Soname.so.1 to
#   /usr/lib/libtq84Soname.so.1.0.1
#
ls -ltr /usr/lib

gcc main.c -ltq84Soname.1 -o bin/use-shared-library-soname-2
