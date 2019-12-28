#!/bin/sh
#created by Alan Turing 2019-12-13 for auto install docker on CentOS 7
# run with root

## blue to echo
function blue(){
    echo -e "\033[35m[ $1 ]\033[0m"
}
## green to echo
function green(){
    echo -e "\033[32m[ $1 ]\033[0m"
}
## Error to warning with blink
function bred(){
    echo -e "\033[31m\033[01m\033[05m[ $1 ]\033[0m"
}
## Error to warning with blink
function byellow(){
    echo -e "\033[33m\033[01m\033[05m[ $1 ]\033[0m"
}
## Error
function red(){
    echo -e "\033[31m\033[01m[ $1 ]\033[0m"
}
## warning
function yellow(){
    echo -e "\033[33m\033[01m[ $1 ]\033[0m"
}

# -------------------------------------------------------------------------
green "卸载老版本"
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate  docker-engine
green "安装依赖"
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
green "设置版本库"
#sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
green "安装docker-ce版本"
sudo yum install -y docker-ce docker-ce-cli containerd.io
green "启动docker服务"
sudo systemctl start docker
green "设置开机启动"
sudo systemctl enable docker

