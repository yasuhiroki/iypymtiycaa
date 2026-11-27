# syntax=docker/dockerfile:1

FROM ubuntu:26.04

LABEL org.opencontainers.image.authors="yasuhiroki"

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# NOTE: Disable Ubuntu's default docker-clean hook so BuildKit apt cache mounts persist downloaded .deb files.
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        gnupg \
        jq \
        less \
        locales \
        man-db \
        openssh-client \
        pkg-config \
        python3-dev \
        ruby-dev \
        ripgrep \
        sudo \
        unzip \
        vim \
        zsh \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm-256color

RUN chsh -s /usr/bin/zsh ubuntu \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu \
    && visudo -cf /etc/sudoers.d/ubuntu

USER ubuntu
WORKDIR /home/ubuntu

RUN curl -O https://raw.githubusercontent.com/yasuhiroki/iypymtiycaa/refs/heads/master/init.sh \
        && zsh init.sh

RUN zsh -c 'cd /home/ubuntu/.iypymtiycaa/init/iypymtiycaa/zshef && source load_local_zshef.sh && zshef install && zshef config' \
        && zsh -c 'source ~/.zshrc'

CMD ["/usr/bin/zsh"]
