#!/bin/sh

if command -v bun >/dev/null; then
    echo "Bun is already installed. Run 'bun upgrade' to upgrade to the latest version."
    exit
fi

BUN_ROOT=/usr/local/bun
BUN_BIN=${BUN_ROOT}/bin
BUN_TMP=~/bun.zip

TARGET=bun-linux-x64

wget -t 5 -q -O ${BUN_TMP} https://github.com/oven-sh/bun/releases/latest/download/${TARGET}.zip && \
mkdir -p ${BUN_ROOT} && \
unzip -q ${BUN_TMP} -d ${BUN_ROOT} && \
mv ${BUN_ROOT}/${TARGET} ${BUN_BIN} && \
ln -s ${BUN_BIN}/bun ${BUN_BIN}/bunx && \
rm -rf ${BUN_TMP}

${BUN_BIN}/bun --version