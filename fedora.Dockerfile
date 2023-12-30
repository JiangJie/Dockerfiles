# # mirrors.tencent.com/jarvisjiang/fedora:latest

FROM docker.io/library/fedora:40

ENV HOME=/root

ARG NODE_BIN=/usr/local/node/bin
ARG DENO_BIN=/usr/local/deno/bin

COPY .inputrc .gitconfig install_node.sh install_deno.sh ${HOME}/

RUN dnf -y upgrade && \
    dnf -y install which wget xz jq zip unzip git && \
    dnf -y autoremove && \
    dnf -y clean all && \
    # 安装node
    bash ${HOME}/install_node.sh && \
    # 安装deno
    bash ${HOME}/install_deno.sh && \
    echo "alias ll='ls -al --color=auto'" >> ${HOME}/.bashrc

# 设置PATH
ENV PATH="${NODE_BIN}:${DENO_BIN}:${PATH}"

WORKDIR ${HOME}