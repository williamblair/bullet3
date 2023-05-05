#!/bin/bash
rm -rf ps3build
mkdir ps3build && cd ps3build

# Run cmake
CMAKE_LIBRARY_DIRECTORIES=$PSL1GHT/ppu/lib:$PS3DEV/portlibs/ppu/lib \
PKG_CONFIG_PATH=$PSL1GHT/portlib/ppu/lib/pkgconfig \
AS=ppu-as \
AR=ppu-ar \
LD=ppu-gcc \
STRIP=ppu-strip \
OBJCOPY=ppu-objcopy \
CC=ppu-gcc \
CXX=ppu-g++ \
cmake .. \
-DCMAKE_INSTALL_PREFIX=/usr/local/ps3dev/portlibs/ppu \
-DCMAKE_CXX_FLAGS=" \
-I$PSL1GHT/ppu/include -I$PSL1GHT/ppu/include/simdmath \
-I$PS3DEV/portlibs/ppu/include -I$PS3DEV/ppu/powerpc64-ps3-elf/include \
-I$PS3DEV/ppu/powerpc64-ps3-elf/include/c++/7.2.0 \
-I$PS3DEV/ppu/include/sys \
-L$PSL1GHT/ppu/lib -L$PSL1GHT/portlibs/ppu/lib \
-D_XOPEN_SOURCE=500" \
-DCMAKE_C_FLAGS=" \
-I$PSL1GHT/ppu/include -I$PSL1GHT/ppu/include/simdmath \
-I$PS3DEV/portlibs/ppu/include  -I$PS3DEV/ppu/powerpc64-ps3-elf/include \
-I$PS3DEV/ppu/include/sys \
-L$PSL1GHT/ppu/lib -L$PSL1GHT/portlibs/ppu/lib \
-D_XOPEN_SOURCE" \
-DCMAKE_DISABLE_FIND_PACKAGE_OpenGL=TRUE \
-DBUILD_CPU_DEMOS=OFF \
-DBUILD_OPENGL3_DEMOS=OFF \
-DBUILD_BULLET2_DEMOS=OFF \
-DBUILD_EXTRAS=OFF \
-DBUILD_SHARED_LIBS=OFF \
-DBUILD_UNIT_TESTS=OFF \
-DCMAKE_C_COMPILER_WORKS=1 \
-DCMAKE_CXX_COMPILER_WORKS=1


# Remove -I/usr/include from build
find ./ -name 'Makefile' | xargs sed -i 's/\-I\/usr\/include//'
find ./ -name '*.make' | xargs sed -i 's/\-I\/usr\/include//'

# Run make
AS=ppu-as \
AR=ppu-ar \
LD=ppu-gcc \
STRIP=ppu-strip \
OBJCOPY=ppu-objcopy \
CC=ppu-gcc \
CXX=ppu-g++ \
make VERBOSE=1 install

