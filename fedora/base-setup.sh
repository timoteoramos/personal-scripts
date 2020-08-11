#!/bin/bash

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
dnf update -y --best --allowerasing
dnf groupinstall -y "Development Tools"
dnf install -y curl git sysstat tmux wget zsh

cat << EOF > /etc/tmux.conf
set -g default-command "\${SHELL}"
set -g default-terminal "screen-256color"
EOF

cat << EOF > /etc/zshenv
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

EDITOR=vi
HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
VISUAL=vi
EOF

cat << EOF > /etc/zshrc
#
# /etc/zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

## shell functions
#setenv() { export \$1=\$2 }  # csh compatibility

# Set prompts
PROMPT='[%n@%m]%~%# '    # default prompt
#RPROMPT=' %~'     # prompt for right side of screen

# bindkey -v             # vi key bindings
# bindkey -e             # emacs key bindings
bindkey ' ' magic-space  # also do history expansion on space

# Provide pathmunge for /etc/profile.d scripts
pathmunge()
{
    if ! echo \$PATH | /bin/grep -qE "(^|:)\$1(\$|:)" ; then
        if [ "\$2" = "after" ] ; then
            PATH=\$PATH:\$1
        else
            PATH=\$1:\$PATH
        fi
    fi
}

_src_etc_profile_d()
{
    #  Make the *.sh things happier, and have possible ~/.zshenv options like
    # NOMATCH ignored.
    emulate -L ksh


    # from bashrc, with zsh fixes
    if [[ ! -o login ]]; then # We're not a login shell
        for i in /etc/profile.d/*.sh; do
	    if [ -r "\$i" ]; then
	        . \$i
	    fi
        done
        unset i
    fi
}
_src_etc_profile_d

unset -f pathmunge _src_etc_profile_d

# Example configuration from ArchWiki ( https://wiki.archlinux.org/index.php/Zsh#Key_bindings )

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="\${terminfo[khome]}"
key[End]="\${terminfo[kend]}"
key[Insert]="\${terminfo[kich1]}"
key[Backspace]="\${terminfo[kbs]}"
key[Delete]="\${terminfo[kdch1]}"
key[Up]="\${terminfo[kcuu1]}"
key[Down]="\${terminfo[kcud1]}"
key[Left]="\${terminfo[kcub1]}"
key[Right]="\${terminfo[kcuf1]}"
key[PageUp]="\${terminfo[kpp]}"
key[PageDown]="\${terminfo[knp]}"
key[Shift-Tab]="\${terminfo[kcbt]}"

# setup key accordingly
[[ -n "\${key[Home]}"      ]] && bindkey -- "\${key[Home]}"      beginning-of-line
[[ -n "\${key[End]}"       ]] && bindkey -- "\${key[End]}"       end-of-line
[[ -n "\${key[Insert]}"    ]] && bindkey -- "\${key[Insert]}"    overwrite-mode
[[ -n "\${key[Backspace]}" ]] && bindkey -- "\${key[Backspace]}" backward-delete-char
[[ -n "\${key[Delete]}"    ]] && bindkey -- "\${key[Delete]}"    delete-char
[[ -n "\${key[Up]}"        ]] && bindkey -- "\${key[Up]}"        up-line-or-history
[[ -n "\${key[Down]}"      ]] && bindkey -- "\${key[Down]}"      down-line-or-history
[[ -n "\${key[Left]}"      ]] && bindkey -- "\${key[Left]}"      backward-char
[[ -n "\${key[Right]}"     ]] && bindkey -- "\${key[Right]}"     forward-char
[[ -n "\${key[PageUp]}"    ]] && bindkey -- "\${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "\${key[PageDown]}"  ]] && bindkey -- "\${key[PageDown]}"  end-of-buffer-or-history
[[ -n "\${key[Shift-Tab]}" ]] && bindkey -- "\${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from \$terminfo valid.
if (( \${+terminfo[smkx]} && \${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
EOF
