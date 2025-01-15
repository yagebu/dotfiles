# vim: set foldmethod=marker:

# Navigation {{{
abbr -a '....' 'cd ../../..'
abbr -a '...' 'cd ../..'
abbr -a '..' 'cd ..'
abbr -a cl clear
# }}}
# Listing {{{
abbr -a df df -h
abbr -a di colordiff
abbr -a du du -c -h
alias ls='ls --hyperlink=auto --color=auto'
abbr -a l 'ls -lh'
abbr -a la 'ls -lha'
# }}}
# sudo {{{
abbr -a svi 'sudo -e'
# }}}
# misc {{{
abbr -a y yazi
alias mutt='mutt -F ~/.config/mutt/muttrc'
abbr -a m 'mutt'
abbr -a ta 'tmux attach'
abbr -a va 'source .venv/bin/activate.fish'
abbr -a vi 'nvim'
# }}}
# systemctl {{{
abbr -a 'log' 'journalctl -r'
abbr -a sc 'sudo systemctl'
abbr -a scu 'systemctl --user'
abbr -a jc 'journalctl'
# pacman {{{
abbr -a pac 'pacman'
abbr -a pacr 'sudo pacman -Rs'
# }}}
# git {{{
abbr -a g 'git'
abbr -a gb 'git branch'
abbr -a gco 'git commit'
abbr -a gd 'git diff'
abbr -a gf 'git fetch --all -p'
abbr -a gfu 'git commit -a --fixup=HEAD'
alias gl='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph -20'
alias glo='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph'
abbr -a gpl 'git pull'
abbr -a gpu 'git push'
abbr -a gr 'git rebase'
abbr -a gri 'git rebase -i'
abbr -a gs 'git status'
abbr -a go 'git checkout'
# }}}
