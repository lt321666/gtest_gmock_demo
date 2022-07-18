#!/bin/bash
# 2022/01/30  by mky

CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/../conf/base_conf.sh
cd ${PROJECT_ROOT}

rm -rf build
rm -rf bin
rm -rf pack

test -e build/ || mkdir build
echo "mkdir build/"

test -e bin/ || mkdir bin
echo "mkdir bin/"

test -e pack/ || mkdir pack
echo "mkdir pack/"