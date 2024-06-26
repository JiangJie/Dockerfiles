# mirrors.tencent.com/hlddz_mina/node_deno:latest

FROM mirrors.tencent.com/ci/tlinux3_ci:latest

ARG HOME=/root

COPY home/node_install.sh home/deno_install.sh ${HOME}/

RUN dnf -y upgrade && \
    # 安装java
    dnf -y install jq java-latest-openjdk && \
    dnf -y autoremove && \
    dnf -y clean all && \
    # 忽略大小写
    echo "set completion-ignore-case on" >> /etc/inputrc && \
    # 安装node
    bash ${HOME}/node_install.sh && \
    # 安装deno
    bash ${HOME}/deno_install.sh

# 设置PATH
ENV PATH=/etc/alternatives/jre_openjdk/bin:/usr/local/node/bin:/usr/local/deno/bin:${PATH}