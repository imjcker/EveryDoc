#!/usr/bin/env bash
#
# Spring boot 启动脚本
#
# System Required:  CentOS 6+, Debian7+, Ubuntu12+
#
# Copyright (C) 2016-2018 Teddysun <i@teddysun.com>
#
# URL: https://blog.imjcker.com
#


red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

pp_jar=-javaagent:/root/pinpoint-agent/pinpoint-bootstrap-1.8.5.jar
pp_id=-Dpinpoint.agentId=
pp_name=-Dpinpoint.applicationName=
# 工作目录
work_dir=/root/micro-service
cd "$work_dir" || return
echo -e "${yellow}当前工作目录：$(pwd)$plain"

services=$(ls $work_dir)
for service in $services
do
  if [ -d "${work_dir}/${service}" ]; then
      if [ $# == 1 ];then
          jar=$(find "$work_dir" -iname "*$1*.jar")
          if [[ ${jar} =~ $service ]]; then
            echo -e "${green}${jar}${plain}"
            nohup java -jar $jar $pp_jar $pp_id$service $pp_name$service >/dev/null 2>&1 &
            break
          fi
      fi
  fi
done
