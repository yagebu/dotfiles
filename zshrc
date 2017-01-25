if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export LANG=en_US.UTF-8
fi

# initialise colors
autoload -U colors
colors

eval $(dircolors ~/.config/zsh/dircolors)

setopt PROMPT_SUBST

PROMPT='%n@%m %{$fg[green]%}%~>%{$reset_color%} '

if [ -n "$VIRTUAL_ENV" ]; then
    PREFIX=$(basename $VIRTUAL_ENV)
    PROMPT="%F{blue}(🐍 $PREFIX)%f $PROMPT"
fi

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

function pew-update() {
    pew rm bw
    pew new bw -d
    pew in bw pip install -e ~/dev/beancount
    pew in bw pip install -e ~/dev/fava
}

# Aliases {{{
# General {{{
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias :q='clear; exit'
alias ag="ag -p ~/.config/agignore"
alias cl='clear'
alias df='df -h'
alias di='colordiff'
alias du='du -c -h'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias l='ls -lh'
alias lsa='ls -a'
alias la='ls -lha'
alias m='mutt -F ~/.config/mutt/muttrc'
alias r='ranger'
alias svi='sudo -e'
alias vi='nvim'
alias sudo='sudo '
# }}}
# git {{{
alias g='git '
alias gb='git branch'
alias gco='git commit'
alias gd='git diff'
alias gf='git fetch'
alias gdw='git diff --color-words'
alias gl='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph -20'
alias glo='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph'
alias gpl='git pull'
alias gpu='git push'
alias gre='git rebase -i'
alias gs='git status'
alias go='git checkout'
# }}}
# macOS {{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias paci='brew install'
    alias pacu='brew update && brew upgrade && brew cleanup && brew cask cleanup && vi +PlugUpgrade +PlugUpdate +qa'
    alias pacs='brew search'
    alias pacr='brew uninstall'
    alias pipu='pip2 install -U -r ~/dev/dotfiles/python/python2-packages && pip3 install -U -r ~/dev/dotfiles/python/python3-packages && pew-update'
fi
# }}}
# Linux {{{
if [[ "$OSTYPE" == "linux-gnu" ]]; then
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
# }}}
# }}}
