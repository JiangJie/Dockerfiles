#!/bin/bash

NODE_DIR=/usr/local/node

# parse json
version=$(curl -fsSL https://nodejs.org/dist/index.json | jq -r '.[0].version')
echo version=${version}

url=https://nodejs.org/dist/${version}/node-${version}-linux-x64.tar.xz
echo url=${url}

wget -q -O - ${url} | tar -xJ --strip-component=1 --one-top-level=${NODE_DIR}

${NODE_DIR}/bin/node --version