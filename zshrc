# initialise colors
autoload -U colors
colors

eval $(dircolors ~/.config/zsh/dircolors)

setopt PROMPT_SUBST

PROMPT='%n@%m %{$fg[green]%}%~>%{$reset_color%} '

# avoid duplicates in history
setopt hist_ignore_all_dups

# load private config
if [ -f ~/Documents/.config/localrc ]
then
    source ~/Documents/.config/localrc
fi

# load some vars for fresh
source ~/.config/fresh/build/shell.sh

# use ag for fzf and ignore Library path on OS X
export FZF_DEFAULT_COMMAND="ag -l -g '' -p ~/.config/agignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# aliases
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias :q='clear; exit'
alias cl='clear'
alias df='df -h'
alias diff='colordiff'
alias du='du -c -h'
alias grep='grep -n --color=auto'
alias l='ledger --wide'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -lha'
alias m='mutt -F ~/.config/mutt/muttrc'
alias r='ranger'
alias va='. venv/bin/activate'
alias svi='sudo -e'
alias vi='nvim'
alias sudo='sudo '

# git
alias gitco='git commit'
alias gitdi='git diff --color-words'
alias gitlo='git log --pretty=format:"%h %s" --graph -20'
alias gitpl='git pull'
alias gitpu='git push'
alias gitst='git status'

# os specific things
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias paci='brew install'
    alias pacu='brew update && brew upgrade --all && brew cleanup && brew cask cleanup'
    alias pacs='brew search'
    alias pacr='brew uninstall'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias log='journalctl -r'
    alias sc='sudo systemctl'
    alias jc='journalctl'
    alias rs-start='systemctl --user start redshift.service'
    alias rs-stop='systemctl --user stop redshift.service'
    # pacman
    alias aura='sudo aura'
    alias pac='aura'
    alias paci='aura -S'
    alias paca='aura -A'
    alias pacr='aura -Rs'
    function pacs() {
        aura -Ss $1; aura -As $1
    }
    alias pacu='aura -Syu && aura -Akua'
    alias pacud='aura -Syu && aura -Akua --devel'
fi
