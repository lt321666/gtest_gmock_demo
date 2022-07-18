#!/bin/bash
# 2022/01/30  by mky
CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/conf/base_conf.sh
cd ${PROJECT_ROOT}
echo "\033[32m ------------------------clean-------------------------------- \033[0m" 
./scripts/base_scripts/clean.sh
if [ $? -ne 0 ];then
    echo -e "\033[41;30m Build Error \033[0m""]]"
    exit 1
fi

echo "\033[32m ------------------------build--------------------------------- \033[0m" 
./scripts/base_scripts/build.sh
if [ $? -ne 0 ];then
    echo -e "\033[41;30m Build Error \033[0m""]]"
    exit 1
fi
echo "\033[32m ------------------------pack---------------------------------- \033[0m" 
./scripts/base_scripts/pack.sh
if [ $? -ne 0 ];then
    echo -e "\033[41;30m Build Error \033[0m""]]"
    exit 1
fi
echo "\033[32m ------------------------remote_install------------------------ \033[0m" 
./scripts/base_scripts/remote_install.sh
if [ $? -ne 0 ];then
    echo -e "\033[41;30m Build Error \033[0m""]]"
    exit 1
fi
echo "\033[32m -------------------------------------------------------------- \033[0m" 