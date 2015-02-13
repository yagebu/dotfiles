# aliases
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias :q='clear; exit'
alias cl='clear'
alias diff='colordiff'
alias du='du -c -h'
alias grep='grep -n --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias svi='sudo -e'
alias vi='vim'
alias sudo='sudo '

# git
alias gitad='git add'
alias gitco='git commit'
alias gitdi='git diff --color-words'
alias gitig='vim .gitignore'
alias gitlo='git log --pretty=format:"%h %s" --graph -20'
alias gitpl='git pull'
alias gitpu='git push -u origin master'
alias gitrm='git rm'
alias gitst='git status'

# os specific things
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias paci='brew install'
    alias pacu='brew update && brew upgrade && brew cleanup && brew cask cleanup'
    alias pacs='brew search'
    alias pacr='brew uninstall'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias log='sudo journalctl -r'
    alias rs-start='systemctl --user start redshift.service'
    alias rs-stop='systemctl --user stop redshift.service'
    # pacman
    alias pacman='sudo pacman'
    alias pac='sudo pacman'
    alias paci='packer -S'
    alias pacr='pacman -Rs'
    alias pacs='packer'
    alias pacss='pacman -Ss'
    alias pacu='packer -Syu'
    alias ll='ls -lFA'
    alias sc='sudo systemctl'
fi
