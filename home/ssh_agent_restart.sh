#!/bin/sh

ssh_agents=$(ps aux | grep ssh-agent | grep -v grep | awk '{print $2}')

if [ -n "$ssh_agents" ]; then
  echo "Killing ssh-agent processes..."
  echo "$ssh_agents" | xargs kill
fi

rm -rf "$HOME/.ssh/ssh-agent.sock"

. /etc/profile.d/sshagent.sh