#!/bin/sh

if [ -n "$1" ]; then
    # 安装指定版本号
    version="v$1"
else
    # 安装最新版本
    # parse json
    version=$(curl -fsSL https://nodejs.org/dist/index.json | jq -r '.[0].version')
    echo "Latest Node.js version = ${version}"
fi

echo "Will install Node.js version = ${version}"

if command -v node >/dev/null; then
    if [ $(node --version) = ${version} ]; then
        echo "Node.js ${version} is already installed"
        exit
    fi
fi

url=https://nodejs.org/dist/${version}/node-${version}-linux-x64.tar.xz
echo "Downloading url=${url}"

NODE_DIR=/usr/local/node

wget -t 5 -q -O - ${url} | tar -xJ --strip-component=1 --one-top-level=${NODE_DIR}

echo "Node.js version = $(${NODE_DIR}/bin/node --version)"

# 更新npm
# 安装pnpm
echo "Updating npm & pnpm"
${NODE_DIR}/bin/node ${NODE_DIR}/bin/npm install -g npm@latest pnpm@latest