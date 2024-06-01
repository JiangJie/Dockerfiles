# Add bun bin to PATH
BUN_PATH="/usr/local/bun/bin"
case "$PATH" in
    *"$BUN_PATH"* ) true ;;
    * ) PATH="$BUN_PATH:$PATH" ;;
esac