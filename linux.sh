. object-files

. link-statically

#
#  Show difference between PIC and in function add
#

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

. show-difference-PIC

. readelf-relocs
