FROM node:14.15.4-alpine3.12
MAINTAINER Alan Turing "570577029@qq.com"
LABEL description="构建专属的文档"
WORKDIR /docs
RUN npm install -g docsify-cli
EXPOSE 3000/tcp
RUN docsify init .
ENTRYPOINT docsify serve .

