# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null

    for keyfile in $HOME/.ssh/id_*; do
        # only private key has corresponding .pub file
        if [[ -f "$keyfile.pub" ]]; then
            ssh-add "$keyfile"
        fi
    done
fi

# User specific environment and startup programs

export PATH=/usr/local/node/bin:/usr/local/deno/bin:$PATH
