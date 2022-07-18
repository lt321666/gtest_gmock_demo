#!/bin/bash
# 2022/01/30  by mky

SOURCE=${BASH_SOURCE[0]}
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
#echo $DIR
#echo $SOURCE

# get current work path 
#PROJECT_ROOT=$(dirname $(readlink -f "$0"))
PROJECT_ROOT=${DIR}
BOOK_TIME=$(date "+%Y-%m-%d %H:%M:%S")
cd ${PROJECT_ROOT}
cd ../../
PROJECT_ROOT=${PWD}

# check root path
if [ -f "${PROJECT_ROOT}/.env" ]; then
    echo -e "PROJECT_ROOT:${PROJECT_ROOT}]"
else
    echo -e "\033[41;30m Find Config Error \033[0m""]]"
    exit 1
fi

# determine profile location
if test -e ${HOME}/.env
then
    PROFILE=${HOME}/.env
elif test -e ${PROJECT_ROOT}/../../.env 
then 
    PROFILE=${PROJECT_ROOT}/../../.env
else
    PROFILE=${PROJECT_ROOT}/.env
fi
#echo -e ${PROFILE}
# read profile parameter
if [ -f "${PROFILE}" ];then
    CUSTOMEPROFILE="$(cat ${PROFILE} | grep custom_profile | awk -F '=' '{print $2}')"
    if test -e ${CUSTOMEPROFILE}
    then
        PROFILE = ${CUSTOMEPROFILE}
    fi
    echo -e "PROFILE:[${PROFILE}]"
    IPADDRESS="$(cat ${PROFILE} | grep ip_address | awk -F '=' '{print $2}')"
    USERNAME="$(cat ${PROFILE} | grep user_name  | awk -F '=' '{print $2}')"
    PASSWORD="$(cat ${PROFILE} | grep user_password | awk -F '=' '{print $2}')"
    PACK_PATH="$(cat ${PROFILE} | grep pack_path | awk -F '=' '{print $2}')"
    CUSTOME_PROFILE="$(cat ${PROFILE} | grep custom_profile | awk -F '=' '{print $2}')"
    BUILD_PLATFORMS="$(cat ${PROFILE} | grep build_platforms | awk -F '=' '{print $2}')"
    BUILD_TYPE="$(cat ${PROFILE} | grep build_type | awk -F '=' '{print $2}')"
    BUILD_TEST="$(cat ${PROFILE} | grep build_tests | awk -F '=' '{print $2}')"
    if [ -f "${PROJECT_ROOT}/.env" ];  
    then
        VER_MAJOR="$(cat ${PROJECT_ROOT}/.env | grep ver_major | awk -F '=' '{print $2}')"
        VER_MINOR="$(cat ${PROJECT_ROOT}/.env | grep ver_minor | awk -F '=' '{print $2}')"
        VER_PATCH="$(cat ${PROJECT_ROOT}/.env | grep ver_patch | awk -F '=' '{print $2}')"
        VER_CYCLE="$(cat ${PROJECT_ROOT}/.env | grep ver_cycle | awk -F '=' '{print $2}')"
        AUTHOR="$(cat ${PROJECT_ROOT}/.env | grep author | awk -F '=' '{print $2}')"
        EMAIL="$(cat ${PROJECT_ROOT}/.env | grep email | awk -F '=' '{print $2}')"   
    else
        echo -e "\033[41;30m Find Config Error \033[0m""]]"
        exit 1
    fi
fi

echo -e "\033[32m -----------------------[user]-----------------------$1 \033[0m" 
echo -e "IPADDRESS       = ${IPADDRESS}"
echo -e "USERNAME        = ${USERNAME}"
echo -e "PASSWORD        = ${PASSWORD}"
echo -e "\033[32m -----------------------[pack]-----------------------$1 \033[0m" 
echo -e "PACK_PATH       = ${PACK_PATH}"
echo -e "\033[32m -----------------------[conf]-----------------------$1 \033[0m" 
echo -e "CUSTOME_PROFILE = ${CUSTOME_PROFILE}"
echo -e "\033[32m -----------------------[build]-----------------------$1 \033[0m" 
echo -e "BUILD_PLATFORMS = ${BUILD_PLATFORMS}"
echo -e "BUILD_TYPE      = ${BUILD_TYPE}"
echo -e "BUILD_TEST      = ${BUILD_TEST}"
echo -e "VER_MAJOR       = ${VER_MAJOR}"
echo -e "VER_MINOR       = ${VER_MINOR}"
echo -e "VER_PATCH       = ${VER_PATCH}"
echo -e "VER_CYCLE       = ${VER_CYCLE}"
echo -e "AUTHOR          = ${AUTHOR}"
echo -e "EMAIL           = ${EMAIL}"
echo -e "BOOK_TIME       = ${BOOK_TIME}"
echo -e "\033[32m -----------------------[endl]-----------------------$1 \033[0m" 
