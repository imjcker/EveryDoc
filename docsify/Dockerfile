FROM node:latest
MAINTAINER Alan Turing "570577029@qq.com"
LABEL description="构建专属的文档"
WORKDIR /docs
RUN npm install -g docsify-cli@latest
EXPOSE 3000/tcp
ENTRYPOINT docsify serve .