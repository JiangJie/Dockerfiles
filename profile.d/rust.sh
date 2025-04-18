# Add rust bin to PATH

RUST_ROOT="/usr/local/rust"

export RUSTUP_HOME="$RUST_ROOT/rustup"
export CARGO_HOME="$RUST_ROOT/cargo"

RUST_PATH="$CARGO_HOME/bin"
case "$PATH" in
    *"$RUST_PATH"* ) true ;;
    * ) PATH="$RUST_PATH:$PATH" ;;
esac
