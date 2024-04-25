# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias ll='ls -al --color=auto'

# add node and deno
export PATH=/usr/local/node/bin:/usr/local/deno/bin:/usr/local/bun/bin:$PATH

. "$HOME/.cargo/env"
/usr/bin/nu
