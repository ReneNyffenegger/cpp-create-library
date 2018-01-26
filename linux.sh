. object-files

. link-statically

#
#  Show difference between PIC and in function add
#
. show-difference-PIC

. link-statically

. shared-library

. link-dynamically

. use-shared-library-LD_LIBRARY_PATH

. move-shared-object

. use-shared-library-no-LD_LIBRARY_PATH




#
#  After moving the shared object to /usr/lib, the executable
#  can be executed without specifying LD_LIBRARY_PATH
#
bin/use-shared-object

. create-dlopen

. LD_DEBUG

. readelf-relocs





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


#
#  TODO
#
#  List symbols in object files
#
nm bin/tq84.0
nm bin/libtq84Soname.so
nm bin/statically-linked
nm bin/statically-linked-PIC

