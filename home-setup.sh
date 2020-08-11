#!/bin/sh

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
rm -Rf ~/.tmux ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cat << EOF > ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'jimeh/tmux-themepack'
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
set -g @plugin 'tmux-plugins/tmux-cpu'

set -g @cpu_low_icon ''
set -g @cpu_medium_icon ''
set -g @cpu_high_icon ''
set -g @ram_low_icon ''
set -g @ram_medium_icon ''
set -g @ram_high_icon ''
set -g @prefix_highlight_bg 'colour01'
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=colour15,bg=colour04'
set -g @prefix_highlight_show_sync_mode 'on'
set -g @prefix_highlight_sync_mode_attr 'fg=colour15,bg=colour05'
set -g @theme-status-left-prefix '#{prefix_highlight}'
set -g @theme-status-right-prefix '#{cpu_fg_color}#{cpu_icon} CPU: #{cpu_percentage} #{ram_fg_color}#{ram_icon} RAM: #{ram_percentage} '
set -g @themepack 'powerline/double/cyan'

run -b '~/.tmux/plugins/tpm/tpm'
EOF

rm -Rf ~/.zshrc ~/.zinit ~/.zcompdump ~/.zprofile ~/.p10k.zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

cat << EOF >> ~/.zshrc

zinit ice blockf
zinit light zsh-users/zsh-completions
zinit wait lucid atload'_zsh_autosuggest_start' light-mode for zsh-users/zsh-autosuggestions

zinit load zdharma/history-search-multi-word
zinit light zdharma/fast-syntax-highlighting

zinit ice depth=1; zinit light romkatv/powerlevel10k
EOF

cat << EOF > ~/.zlogin
if [ -n "\$SSH_TTY" ] && [ -z "\$TMUX" ]; then tmux new-session -A -s 0; exit; fi
EOF
