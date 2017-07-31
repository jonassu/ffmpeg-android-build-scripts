#!/bin/bash
#Change NDK to your Android NDK location
NDK=/opt/tools/android-sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-18/arch-x86/
PREBUILT=$NDK/toolchains/x86-4.9/prebuilt/darwin-x86_64


GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/i686-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/i686-linux-android- \
--nm=$PREBUILT/bin/i686-linux-android-nm"


function build_x86
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./android/x86 \
  --arch=x86 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="-O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8" \
  --enable-static \
  --disable-shared \
  --disable-asm \
  --extra-cflags="-fPIC -march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  --disable-doc \
  ${MODULES}

  make clean
  make
  make install
}

build_x86


echo Android X86 builds finished