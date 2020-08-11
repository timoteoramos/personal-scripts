#!/bin/bash

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
apt update
apt install -y build-essential curl git sysstat tmux wget zsh

cat << EOF > /etc/tmux.conf
set -g default-command "\${SHELL}"
set -g default-terminal "screen-256color"
EOF

cat << EOF > /etc/zsh/zshenv
# /etc/zsh/zshenv: system-wide .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

if [[ -z "\$PATH" || "\$PATH" == "/bin:/usr/bin" ]]
then
	export PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi

EDITOR=vim.tiny
HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
VISUAL=vim.tiny
EOF
