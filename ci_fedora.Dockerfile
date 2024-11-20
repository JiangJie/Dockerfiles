# mirrors.tencent.com/jarvisjiang/ci_fedora:latest

FROM registry.fedoraproject.org/fedora-minimal:latest as base

ARG HOME=/root

COPY home/.bash* home/*_install.sh ${HOME}/
COPY profile.d/alias.sh profile.d/bun.sh profile.d/deno.sh profile.d/node.sh /etc/profile.d/

RUN dnf5 -y upgrade && \
    dnf5 -y install which wget openssl-devel procps-ng jq tar xz zip unzip lsof vim \
    # 安装必要软件包 git java gcc
    git git-lfs \
    java-latest-openjdk gcc && \
    dnf5 -y autoremove && \
    dnf5 -y clean all && \
    # 忽略大小写
    echo "set completion-ignore-case on" >> /etc/inputrc && \
    # 安装rust
    bash ${HOME}/rust_install.sh && \
    # 安装node
    bash ${HOME}/node_install.sh && \
    # 安装deno
    bash ${HOME}/deno_install.sh && \
    # 安装bun
    bash ${HOME}/bun_install.sh

# 空白镜像
FROM scratch
COPY --from=base / /

ARG RUST_ROOT=/usr/local/rust

# 一定要有rust的环境变量
ENV RUSTUP_HOME=${RUST_ROOT}/rustup \
    CARGO_HOME=${RUST_ROOT}/cargo \
    PATH=${RUST_ROOT}/cargo/bin:/usr/local/node/bin:/usr/local/deno/bin:/usr/local/bun/bin:${PATH}

SHELL ["/bin/bash", "-c"]

WORKDIR /data/landun/workspace