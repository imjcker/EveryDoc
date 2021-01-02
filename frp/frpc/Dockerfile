FROM alpine:3.8
MAINTAINER imjcker

WORKDIR /
ENV FRP_VERSION 0.34.3
RUN set -x && \
        wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
        mkdir /frp && \
        tar xzf frp_${FRP_VERSION}_linux_amd64.tar.gz --strip-components 1 -C /frp/ && \
        cd frp

VOLUME /frp

CMD /frp/frpc -c /frp/frpc.ini

