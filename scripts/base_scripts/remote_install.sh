#!/bin/bash
# 2022/01/30  by mky

CURRENT_PATH=$(dirname $(readlink -f "$0"))
. ${CURRENT_PATH}/../conf/base_conf.sh
cd ${PROJECT_ROOT}

echo $pwd
function remoteSendFiles () {
expect << EOF
    set timeout -1;
    # 删除目标文件到远端
    spawn ssh $USERNAME@$IPADDRESS;
    expect {
        "*(yes/no*" {send -- "yes\r"; exp_continue}
        "password:" {send -- "$PASSWORD\r";}
    };
    expect "*]#" {send -- "rm -rf $1\r";}
    expect "*]#" {send -- "exit\r";}
    expect eof;
    
    # 发送目标文件到远端
    spawn -noecho scp -r $PACK_PATH/pack$1 ${USERNAME}@${IPADDRESS}:$1 ${@:3}
    expect {
       "*(yes/no*" {send -- "yes\r"; exp_continue}
       "password:" {send -- "$PASSWORD\r";}
    };
    expect eof;
    
    # 加权目标文件到远端
    spawn ssh $USERNAME@$IPADDRESS;
    expect {
        "*(yes/no*" {send -- "yes\r"; exp_continue}
        "password:" {send -- "$PASSWORD\r";}  
    };
    expect "*]#" {send -- "chmod +x $1\r";}
    expect "*]#" {send -- "exit\r";}
    expect eof;
EOF
    echo -e "\033[32m ----------------------------------------------$1 \033[0m" 
}

function remoteInstallTargetfiles(){
    echo -e "\033[32m ---------------------remoteInstallTargetfiles-------------------------- \033[0m" 
expect << EOF
    set timeout -1;
    spawn ssh $USERNAME@$IPADDRESS;
    expect {
        "*(yes/no*" {send -- "yes\r"; exp_continue}
        "password:" {send -- "$PASSWORD\r";}
    };
    expect "*]#" {send -- "kill -9 $(ps -ef | grep Tests | grep -v grep | awk -F ' ' '{print $2}')\r";}
    expect "*]#" {send -- "kill -9 $(ps -ef | grep sample_project | grep -v grep | awk -F ' ' '{print $2}')\r";}
    expect "*]#" {send -- "exit\r";}
    expect eof;
EOF
    echo -e "\033[32m ----------------------remoteSendFiles---------------------------------- \033[0m" 
    arr=$1
    for i in ${arr[*]}; do
       remoteSendFiles $i
    done
expect << EOF
    set timeout -1;
    spawn ssh $USERNAME@$IPADDRESS;
    expect {
        "*(yes/no*" {send -- "yes\r"; exp_continue}
        "password:" {send -- "$PASSWORD\r";}
    };
    #expect "*]#" {send -- "reboot\r";}
    expect "*]#" {send -- "exit\r";}
    expect eof;
EOF
echo -e "\033[32m --------------------------exit------------------------------ \033[0m" 
}
targetFiles=(
    /usr/bin/sample_project
    /usr/bin/Tests
    /usr/lib/liblibemb.a 
    /usr/lib/libmodule_logger.a
    )
remoteInstallTargetfiles "${targetFiles[*]}"

#export QT_QPA_PLATFORM=linuxfb:rotation=0
#export QT_QPA_FB_DRM=1
#export LD_LIBRARY_PATH=/usr/lib/opencv-4.5.2/lib:/usr/lib:/lib
