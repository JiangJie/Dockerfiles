# Start agent
# Reuse ssh-agent process if already started
SOCK="$HOME/.ssh/ssh-agent.sock"
if [ ! -f "$SOCK" ]; then
    export SSH_AUTH_SOCK="$SOCK"
    ssh-agent -s -a "$SOCK" 2>/dev/null >/dev/null
fi

# Auto ssh-add private keys
for keyfile in $HOME/.ssh/private/id_*; do
    if [[ -f $keyfile && ! $keyfile =~ \.pub$ ]]; then
        # Add private key file
        ssh-add "$keyfile" 2>/dev/null >/dev/null
    fi
done