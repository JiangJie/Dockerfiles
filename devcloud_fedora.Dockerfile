# mirrors.tencent.com/jarvisjiang/devcloud_fedora:latest

FROM quay.io/fedora/fedora-minimal:latest as base

ARG HOME=/root
ARG TMP_DIR=/data/temp

COPY home/* ${HOME}/
# 此处不需要
RUN rm -rf ${HOME}/pip.conf
COPY profile.d/* /etc/profile.d/
COPY yum.repos.d/* /etc/yum.repos.d/
COPY env/99-codev.conf /etc/ssh/sshd_config.d/
COPY env/mkpasswd.sh ${TMP_DIR}/
COPY codev/bin/run /codev/bin/

RUN dnf5 -y upgrade && \
    dnf5 -y install telnet iputils gawk which lsof \
    passwd wget openssh-server openssl-devel procps-ng jq tar xz zip unzip vim nushell \
    # 安装必要软件包 git java .net golang gcc
    git git-lfs \
    java-latest-openjdk dotnet-sdk-9.0 golang gcc && \
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

# nushell配置覆盖安装附带的默认文件
COPY home/.config/nushell/config.nu ${HOME}/.config/nushell/

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 空白镜像
FROM scratch
COPY --from=base / /

WORKDIR /data/workspace

# 这一行一定要有，否则会跑不起来
ENTRYPOINT ["/codev/bin/run", "--"]