# Auto ssh-add public keys
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null

    for keyfile in $HOME/.ssh/id_*; do
        # Only private key has corresponding .pub file
        if [[ -f "$keyfile.pub" ]]; then
            ssh-add "$keyfile"
        fi
    done
fi