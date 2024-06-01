# Add deno bin to PATH
DENO_PATH="/usr/local/deno/bin"
case "$PATH" in
    *"$DENO_PATH"* ) true ;;
    * ) PATH="$DENO_PATH:$PATH" ;;
esac