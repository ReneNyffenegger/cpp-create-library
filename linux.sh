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

. create-soname-library

. link-soname-library

#
#  Installing the library
#
. install-soname-library

. LD_DEBUG

. readelf-relocs


#
#  TODO
#
#  List symbols in object files
#
nm bin/tq84.0
nm bin/libtq84Soname.so
nm bin/statically-linked
nm bin/statically-linked-PIC

