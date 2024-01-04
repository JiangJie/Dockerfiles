# mirrors.tencent.com/jarvisjiang/devcloud_fedora:latest
FROM registry.fedoraproject.org/fedora-minimal:latest as base

ARG HOME=/root
ARG TMP_DIR=/data/temp

COPY home/.bash_profile \
    home/.bashrc \
    home/.gitconfig \
    home/install_node.sh \
    home/install_deno.sh \
    ${HOME}/
COPY env/99-codev.conf /etc/ssh/sshd_config.d/
COPY env/mkpasswd.sh ${TMP_DIR}/
COPY codev/bin/run /codev/bin/

RUN dnf5 -y upgrade && \
    # 安装必要软件包 git java .net
    dnf5 -y install which passwd wget openssh-server jq tar xz zip unzip git java-latest-openjdk dotnet-sdk-8.0 && \
    dnf5 -y autoremove && \
    dnf5 -y clean all

# 安装node
RUN bash ${HOME}/install_node.sh

# 安装deno
RUN bash ${HOME}/install_deno.sh

# 远程开发登录需要
RUN ssh-keygen -A
RUN echo "$($TMP_DIR/mkpasswd.sh)" | passwd root --stdin && \
    rm -rf ${TMP_DIR}

# 忽略大小写
RUN echo "set completion-ignore-case on" >> /etc/inputrc

# 空白镜像
FROM scratch
COPY --from=base / /

WORKDIR /data/workspace

# 这一行一定要有，否则会跑不起来
ENTRYPOINT ["/codev/bin/run", "--"]