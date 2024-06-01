# Add node bin to PATH
NODE_PATH="/usr/local/node/bin"
case "$PATH" in
    *"$NODE_PATH"* ) true ;;
    * ) PATH="$NODE_PATH:$PATH" ;;
esac