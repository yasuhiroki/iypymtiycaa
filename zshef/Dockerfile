FROM ubuntu:16.04
MAINTAINER yasuhiroki

RUN apt-get clean && apt-get update
RUN apt-get install -y locales git sudo curl zsh make gcc connect-proxy man fonts-horai-umefont
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TERM xterm-256color

RUN git clone https://github.com/yasuhiroki/zshef.git /root/.zshef
RUN  mkdir -p /root/zshef /root/.iypymtiycaa
COPY cookbooks /root/zshef/cookbooks

RUN zsh -c 'source /root/.zshef/init.sh; cd /root/zshef && zshef run'
