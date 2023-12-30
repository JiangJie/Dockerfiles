# mirrors.tencent.com/jarvisjiang/devcloud:latest

FROM mirrors.tencent.com/devcloud/codev-tlinux4:latest

ENV HOME=/root

ARG NODE_BIN=/usr/local/node/bin
ARG DENO_BIN=/usr/local/deno/bin

COPY .inputrc .gitconfig install_node.sh install_deno.sh ${HOME}/

RUN dnf -y upgrade && \
    # 安装java .net
    dnf -y install xz jq java-17-konajdk dotnet-sdk-7.0 && \
    dnf -y autoremove && \
    dnf -y clean all && \
    # 安装node
    bash ${HOME}/install_node.sh && \
    # 安装deno
    bash ${HOME}/install_deno.sh

# 设置PATH
ENV PATH="${NODE_BIN}:${DENO_BIN}:${PATH}"