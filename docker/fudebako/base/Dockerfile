FROM ubuntu
MAINTAINER Yasuhiro Kiyota

RUN apt-get clean && apt-get update
RUN apt-get install locales
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TERM xterm-256color

SHELL ["/bin/bash", "-c"]

RUN apt -y update \
    && apt -y upgrade \
    && apt -y install git sudo curl zsh make gcc connect-proxy man fonts-horai-umefont

RUN apt -y install libboost-all-dev cmake openjdk-8-jre

RUN sed -i 's/bash/zsh/' /etc/passwd

RUN mkdir -p /root/github.com/yasuhiroki/ \
    && cd /root/github.com/yasuhiroki/ \
    && git clone https://github.com/yasuhiroki/vimrc \
    && cd vimrc \
    && bash ./install-vim.sh \
    && bash ./update.sh

RUN mkdir -p /root/github.com/yasuhiroki/ \
    && cd /root/github.com/yasuhiroki/ \
    && git clone https://github.com/yasuhiroki/iypymtiycaa

RUN curl https://raw.githubusercontent.com/yasuhiroki/zshef/master/install.sh | sh

RUN cd /root/github.com/yasuhiroki/iypymtiycaa/zshef && zshef run
