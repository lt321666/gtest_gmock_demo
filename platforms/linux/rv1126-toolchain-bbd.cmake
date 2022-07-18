set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(SYSROOT_PATH  /opt/rv1126_sdk/host/arm-buildroot-linux-gnueabihf/sysroot)
set(CMAKE_SYSROOT "${SYSROOT_PATH}")
message(STATUS  "Using sysroot path as ${SYSROOT_PATH}")

SET(CMAKE_FIND_ROOT_PATH  /opt/rv1126_sdk/host/arm-buildroot-linux-gnueabihf/sysroot)
set(ENV{PKG_CONFIG_PATH} ${SYSROOT_PATH}/usr/lib/pkgconfig:$ENV{PKG_CONFIG_PATH})

set(TOOLCHAIN_PATH /opt/rv1126_sdk/cross-compiler/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf)
set(TOOLCHAIN_HOST ${TOOLCHAIN_PATH}/bin/arm-linux-gnueabihf)

set(PKG_CONFIG_EXECUTABLE "/opt/rv1126_sdk/host/bin/pkg-config")
#set(PKG_CONFIG_PATH /opt/host/arm-buildroot-linux-gnueabihf/sysroot/usr/lib/pkgconfig)

set(TOOLCHAIN_CC "${TOOLCHAIN_HOST}-gcc")
set(TOOLCHAIN_CXX "${TOOLCHAIN_HOST}-g++")

set(CMAKE_C_COMPILER ${TOOLCHAIN_CC})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_CXX})

SET(YOUR_TARGET_OS linux)
SET(YOUR_TARGET_ARCH armv7-a)

SET(CMAKE_SKIP_BUILD_RPATH TRUE)
SET(CMAKE_SKIP_RPATH TRUE)

add_link_options("LINKER:-rpath-link,\
/opt/rv1126_sdk/host/arm-buildroot-linux-gnueabihf/sysroot/lib:\
/opt/rv1126_sdk/host/arm-buildroot-linux-gnueabihf/sysroot/usr/lib:\
/opt/rv1126_sdk/opencv-arm/opencv-4.5.2/lib"
)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

