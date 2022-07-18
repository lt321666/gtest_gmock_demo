#!/bin/bash
# 2022/01/30  by mky

CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/../conf/base_conf.sh
cd ${PROJECT_ROOT}

dos2unix ./scripts/base_scripts/*
dos2unix ./scripts/task.sh
dos2unix ./conf/scripts_config
dos2unix ./src/*