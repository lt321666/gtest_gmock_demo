#!/bin/bash
# 2022/01/30  by mky

CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/../conf/base_conf.sh
cd ${PROJECT_ROOT}


rm -rf pack
test -e pack/ || mkdir pack
echo "pack start"
echo "pack mkdir pack/"
mkdir -p pack/usr/bin
echo "pack mkdir pack/usr/bin/"
mkdir -p pack/usr/lib
echo "pack mkdir pack/usr/lib/"
mkdir -p pack/usr/share/dbus-1/system.d
echo "pack mkdir pack/usr/share/dbus-1/system.d/"
mkdir -p pack/userdata
echo "pack mkdir pack/userdata/"
echo "pack ..."
cp bin/Tests                                                          pack/usr/bin/Tests
cp bin/bin/sample_project                                             pack/usr/bin/sample_project
cp bin/lib/liblibemb.a                                                pack/usr/lib/liblibemb.a
cp bin/lib/libmodule_logger.a										  pack/usr/lib/libmodule_logger.a


mkdir -p  $PACK_PATH/pack
cp -r  pack/* $PACK_PATH/pack
#cd pack
#zip -r -q -o pack.zip *

echo "pack finash"