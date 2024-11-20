# mirrors.tencent.com/jarvisjiang/devcloud_fedora:latest

FROM registry.fedoraproject.org/fedora-minimal:latest as base

ARG HOME=/root \
    TMP_DIR=/data/temp

COPY home/* ${HOME}/
COPY profile.d/* /etc/profile.d/
COPY env/99-codev.conf /etc/ssh/sshd_config.d/
COPY env/mkpasswd.sh ${TMP_DIR}/
COPY codev/bin/run /codev/bin/

RUN dnf5 -y upgrade && \
    dnf5 -y install dnf5-plugins && \
    # 为了安装nushell
    dnf5 -y copr enable atim/nushell && \
    dnf5 -y install which passwd wget openssh-server openssl-devel procps-ng jq tar xz zip unzip lsof vim nushell \
    # 安装必要软件包 git java .net gcc
    git git-lfs \
    java-latest-openjdk dotnet-sdk-9.0 gcc && \
    dnf5 -y autoremove && \
    dnf5 -y clean all && \
    # 远程开发登录需要
    ssh-keygen -A && \
    echo "$($TMP_DIR/mkpasswd.sh)" | passwd root --stdin && \
    rm -rf ${TMP_DIR} && \
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

WORKDIR /data/workspace

# 这一行一定要有，否则会跑不起来
ENTRYPOINT ["/codev/bin/run", "--"]