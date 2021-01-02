FROM alpine:3.8
MAINTAINER imjcker

WORKDIR /
ENV FRP_VERSION 0.34.3
RUN set -x && \
        wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
        tar xzf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
        cd frp_${FRP_VERSION}_linux_amd64 && \
        cat>/frp_${FRP_VERSION}_linux_amd64/frpc.ini<<EOF
# frpc.ini
[common]
server_addr = ${frps_ip}
server_port = 7000
dashboard_port = 7400
dashboard_user = admin
dashboard_pwd = admin
EOF

VOLUME /frp_${FRP_VERSION}_linux_amd64

CMD /frp_${FRP_VERSION}_linux_amd64/frpc -c /frp_${FRP_VERSION}_linux_amd64/frpc.ini

# docker build -t imjcker/frpc:v0.34.3 ./frp/frpc/
# docker run -d --name frpc -p 7400:7400 -v /etc/frp:/frp_0.34.3_linux_md64 -e frps_ip=47.240.46.65 imjcker/frpc:v0.34.3
