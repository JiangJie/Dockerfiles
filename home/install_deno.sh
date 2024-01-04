#!/bin/bash

DENO_BIN=/usr/local/deno/bin
DENO_TMP=~/deno.zip

wget -q -O ${DENO_TMP} https://github.com/denoland/deno/releases/latest/download/deno-x86_64-unknown-linux-gnu.zip && \
mkdir -p ${DENO_BIN} && \
unzip -q ${DENO_TMP} -d ${DENO_BIN} && \
rm -rf ${DENO_TMP}

${DENO_BIN}/deno --version