# mirrors.tencent.com/hlddz_mina/node_deno:latest

FROM mirrors.tencent.com/ci/tlinux3_ci:latest

ARG HOME=/root
# 固定安装1.37.0
ARG DENO_VERSION=1.37.0

COPY .gitconfig install_node.sh install_deno.sh ${HOME}/

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
ENV PATH="/etc/alternatives/jre_openjdk/bin:/usr/local/node/bin:/usr/local/deno/bin:${PATH}"

# deno降级
RUN deno upgrade --version ${DENO_VERSION}