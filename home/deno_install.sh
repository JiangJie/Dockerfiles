#!/bin/sh

if command -v deno >/dev/null; then
    echo "Deno is already installed. Run 'deno upgrade' to upgrade to the latest version."
    exit
fi

DENO_BIN=/usr/local/deno/bin
DENO_TMP=~/deno.zip

wget -t 5 -q -O ${DENO_TMP} https://github.com/denoland/deno/releases/latest/download/deno-x86_64-unknown-linux-gnu.zip && \
mkdir -p ${DENO_BIN} && \
unzip -q ${DENO_TMP} -d ${DENO_BIN} && \
rm -rf ${DENO_TMP}

${DENO_BIN}/deno --version