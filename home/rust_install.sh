#!/bin/sh

if command -v rustup >/dev/null; then
    echo "Rust is already installed. Run 'rustup update' to upgrade to the latest version."
    exit
fi

RUST_ROOT=/usr/local/rust

export RUSTUP_HOME=${RUST_ROOT}/rustup
export CARGO_HOME=${RUST_ROOT}/cargo

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --profile default --default-toolchain stable --default-host x86_64-unknown-linux-gnu

${CARGO_HOME}/bin/rustup default stable
${CARGO_HOME}/bin/rustc --version