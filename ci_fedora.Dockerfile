# mirrors.tencent.com/jarvisjiang/ci_fedora:latest

FROM quay.io/fedora/fedora-minimal:latest as base

ARG HOME=/root

COPY home/.bash* home/node_install.sh home/deno_install.sh home/bun_install.sh ${HOME}/
COPY home/.pip/pip.conf ${HOME}/.pip/
COPY profile.d/alias.sh profile.d/bun.sh profile.d/deno.sh profile.d/node.sh /etc/profile.d/

RUN dnf5 -y upgrade && \
    dnf5 -y install which wget openssl-devel procps-ng jq tar xz zip unzip lsof vim \
    # 安装必要软件包 git java pip
    git git-lfs \
    java-latest-openjdk python3-pip && \
    dnf5 -y autoremove && \
    dnf5 -y clean all && \
    # 忽略大小写
    echo "set completion-ignore-case on" >> /etc/inputrc && \
    # 安装node
    bash ${HOME}/node_install.sh && \
    # 安装deno
    bash ${HOME}/deno_install.sh && \
    # 安装bun
    bash ${HOME}/bun_install.sh

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 空白镜像
FROM scratch
COPY --from=base / /

# ci可能不通过bash执行命令，所以需要显式设置环境变量
ENV PATH=/usr/local/node/bin:/usr/local/deno/bin:/usr/local/bun/bin:${PATH}

SHELL ["/bin/bash", "-c"]

WORKDIR /data/landun/workspace