FROM ubuntu
MAINTAINER Yasuhiro Kiyota

ENV LANG en_US.UTF-8
ENV TERM xterm-256color

SHELL ["/bin/bash", "-c"]

RUN apt -y update \
    && apt -y upgrade \
    && apt -y install git sudo curl zsh make gcc

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

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-ag.sh

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-fzf.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-graphviz.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-node.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-pbcopy.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-java.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-plantuml.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-rbenv.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-tmux.sh \

RUN cd /root/github.com/yasuhiroki/iypymtiycaa \
    && bash install/install-zsh.sh

