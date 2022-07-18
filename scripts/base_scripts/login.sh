#!/bin/bash
# 2022/01/30  by mky

CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/../conf/base_conf.sh
cd ${PROJECT_ROOT}

expect -c "
    set timeout -1;
    spawn -noecho ssh -o StrictHostKeyChecking=no $IPADDRESS -l$USERNAME
    expect \"*assword:*\" {send -- \"$PASSWORD\r\";};
    interact;
"
