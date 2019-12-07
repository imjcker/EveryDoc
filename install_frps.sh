#!/usr/bin/env bash
#author Alan Turing
#date 2019.12
#fetures: install frps

is_wget_installed=$(yum list installed | grep wget)
if [[ "" == "$is_wget_installed" ]]; then
    echo "检查到系统没有安装wget,开始安装wget"
    sleep 1s
    yum -y install wget
fi
echo "开始下载: https://github.com/fatedier/frp/releases/download/v0.30.0/frp_0.30.0_linux_amd64.tar.gz"
wget -q -c --tries=3 -O "frp.tar.gz" https://github.com/fatedier/frp/releases/download/v0.30.0/frp_0.30.0_linux_amd64.tar.gz

echo "开始解压压缩包: frp.tar.gz 到临时文件 ./temp"
mkdir ./temp
tar -zxv frp.tar.gz --strip-components 1 -C ./temp/

echo "拷贝frps到/usr/bin目录"
if [[ -f "/usr/bin/frps" ]]; then
    echo "删除原有frps"
    rm -f /usr/bin/frps
fi
cp ./temp/frps /usr/bin

echo "初始化配置文件:/etc/frp/frps.ini"
if [[ -f "/etc/frp/frps.ini" ]]; then
    > /etc/frp/frps.ini
fi
cat>/etc/frp/frps.ini<<EOF
# frps.ini
[common]
bind_port = 7000
vhost_http_port = 80
dashboard_port = 7500
dashboard_user = admin
dashboard_pwd = admin
EOF

echo "初始化服务配置: /etc/systemd/system/frps.service"
if [[ -f "/etc/systemd/system/frps.service" ]]; then
    > /etc/systemd/system/frps.service
fi
cat>/etc/systemd/system/frps.service<<EOF
[Unit]
Description=FRP Server Daemon

[Service]
Type=simple
ExecStartPre=-/usr/sbin/setcap cap_net_bind_service=+ep /usr/bin/frps
ExecStart=/usr/bin/frps -c /etc/frp/frps.ini
Restart=always
RestartSec=20s
User=nobody
PermissionsStartOnly=true

[Install]
WantedBy=multi-user.target
EOF

echo "开始启动服务:frps.service"
sleep 1s
systemctl daemon-reload
systemctl start frps
echo "设置开机启动..."
sleep 1s
systemctl enable frps

frps_pid=$(ps -ef|grep frps |awk '{print $1}')
if [[ "" == "$frps_pid" ]]; then
    echo "frps.service 自动启动失败"
else
    echo "安装完毕,删除临时文件..."
    rm -rf ./temp
    rm ./*frp*.tar.gz
fi
