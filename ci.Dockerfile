# mirrors.tencent.com/hlddz_mina/node_deno:latest

FROM mirrors.tencent.com/ci/tlinux3_ci:latest

ENV HOME=/root

ARG JAVA_BIN=/etc/alternatives/jre_openjdk/bin
ARG NODE_BIN=/usr/local/node/bin
ARG DENO_BIN=/usr/local/deno/bin
# 固定安装1.37.0
ARG DENO_VERSION=1.37.0

COPY .inputrc .gitconfig install_node.sh install_deno.sh ${HOME}/

RUN dnf -y upgrade && \
    # 安装java
    dnf -y install jq java-latest-openjdk && \
    dnf -y autoremove && \
    dnf -y clean all && \
    # 安装node
    bash ${HOME}/install_node.sh && \
    # 安装deno
    bash ${HOME}/install_deno.sh

# 设置PATH
ENV PATH="${JAVA_BIN}:${NODE_BIN}:${DENO_BIN}:${PATH}"

# deno降级
RUN deno upgrade --version ${DENO_VERSION}