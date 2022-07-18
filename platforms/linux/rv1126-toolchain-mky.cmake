MESSAGE(STATUS "Configure Cross Compiler")
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_PROCESSOR arm)


SET(SYSROOT_PATH  /opt/rv1126_sdk/host/arm-buildroot-linux-gnueabihf/sysroot)
SET(CMAKE_SYSROOT "${SYSROOT_PATH}")
MESSAGE(STATUS  "Using sysroot path as ${SYSROOT_PATH}")

SET(ENV{PKG_CONFIG_PATH} ${SYSROOT_PATH}/usr/lib/pkgconfig:$ENV{PKG_CONFIG_PATH})
SET(PKG_CONFIG_EXECUTABLE "/opt/rv1126_sdk/host/bin/pkg-config")

SET(CMAKE_C_COMPILER        /opt/rv1126_sdk/cross-compiler/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER      /opt/rv1126_sdk/cross-compiler/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++)

# set searching rules for cross-compiler
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

SET(YOUR_TARGET_OS linux)
SET(YOUR_TARGET_ARCH armv7-a)

SET(CMAKE_SKIP_BUILD_RPATH TRUE)
SET(CMAKE_SKIP_RPATH TRUE)

# set g++ param
# -fopenmp link libgomp
SET(CMAKE_CXX_FLAGS "-rdynamic -std=c++17 -march=armv7-a -mfloat-abi=hard -mfpu=neon-vfpv4 \
    -ffunction-sections \
    -fdata-sections -O2 -fstack-protector-strong -lm -ldl -lstdc++\
    ${CMAKE_CXX_FLAGS}")