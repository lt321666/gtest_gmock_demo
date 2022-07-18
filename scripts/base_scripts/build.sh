#!/bin/bash
# 2022/01/30  by mky

CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/../conf/base_conf.sh
cd ${PROJECT_ROOT}


test -e build/ || mkdir build
echo "mkdir build/"

test -e bin/ || mkdir bin
echo "mkdir bin/"

cd build/

#rm -rf *
# 指定linux armv7-a 交叉编译工具链
#/opt/cmake-3.21.1/bin/cmake -DBUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../platforms/linux/rv1126-toolchain-mky.cmake ..
/opt/cmake-3.21.1/bin/cmake \
-DBUILD_TESTS=${BUILD_TEST} \
-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
-DAUTHOR=${AUTHOR} \
-DBOOK_TIME=${BOOK_TIME} \
-DEMAIL=${EMAIL} \
-DPROJECT_VERSION=${VER_MAJOR}.${VER_MINOR}.${VER_PATCH}${VER_CYCLE} \
-DCMAKE_TOOLCHAIN_FILE=${BUILD_PLATFORMS} \
..  

if [ $? -ne 0 ];then
    echo -e "\033[41;30m Build Error \033[0m""]]"
    exit 1
fi

make -j install

if [ $? -ne 0 ];then
    echo -e "\033[41;30m Build Error \033[0m""]]"
    exit 1
fi
