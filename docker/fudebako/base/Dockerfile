# syntax=docker/dockerfile:1

FROM ubuntu:26.04

LABEL org.opencontainers.image.authors="Yasuhiro Kiyota"

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

RUN mkdir -p /home/ubuntu/github.com/yasuhiroki /home/ubuntu/.iypymtiycaa /home/ubuntu/mybin \
    && git clone --depth=1 https://github.com/yasuhiroki/iypymtiycaa /home/ubuntu/github.com/yasuhiroki/iypymtiycaa \
    && git clone --depth=1 https://github.com/yasuhiroki/zshef.git /home/ubuntu/.zshef \
    && zsh -c 'source /home/ubuntu/.zshef/init.sh && cd /home/ubuntu/github.com/yasuhiroki/iypymtiycaa/zshef && zshef run'

ENV PATH="/home/ubuntu/.local/bin:/home/ubuntu/go/bin:/home/ubuntu/.cargo/bin:${PATH}"

CMD ["/usr/bin/zsh"]
