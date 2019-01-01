for dir in ~/bin ~/.local/bin "$PYENV_ROOT/bin"; do
    if [[ -z ${path[(r)$dir]} ]]; then
        path=($dir $path)
    fi
done

# initialise colors
autoload -U colors
colors

eval "$(dircolors ~/.config/zsh/dircolors)"

setopt PROMPT_SUBST

PROMPT='%n@%m %{$fg[green]%}%~>%{$reset_color%} '

if [ -n "$VIRTUAL_ENV" ]; then
    PREFIX=$(basename "$VIRTUAL_ENV")
    PROMPT="%F{blue}(🐍 $PREFIX)%f $PROMPT"
fi

# avoid duplicates in history
setopt hist_ignore_all_dups

# load private config
if [ -f ~/Documents/.config/localrc ]; then
    source ~/Documents/.config/localrc
fi

# use ag for fzf and ignore Library path on OS X
export FZF_DEFAULT_COMMAND="ag -l -g '' -p ~/.config/agignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(pyenv init -)"

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
alias ta='tmux attach'
alias vi='nvim'
alias sudo='sudo '
# }}}
# git {{{
alias g='git '
alias gb='git branch'
alias gco='git commit'
alias gd='git diff'
alias gf='git fetch'
alias gfu='git commit -a --fixup=HEAD'
alias gdw='git diff --color-words'
alias gl='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph -20'
alias glo='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph'
alias gpl='git pull'
alias gpu='git push'
alias gr='git rebase'
alias gri='git rebase -i'
alias gs='git status'
alias cgo=$(which go)
alias go='git checkout'
# }}}
# Linux {{{
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias log='journalctl -r'
    alias sc='sudo systemctl'
    alias scu='systemctl --user'
    alias jc='journalctl'
    # pacman
    alias pac='pikaur'
    alias paci='pikaur -S'
    alias pacr='sudo pacman -Rs'
    alias pacs='pikaur -Ss'
    alias pacu='pikaur -Syu'

    function pipu() {
        pip install --user -U \
            -e ~/dev/beancount \
            -e ~/dev/fava \
            -e ~/dev/fava-plugins \
            -e ~/dev/smart_importer
    }

    function pacua() {
        pikaur -Syu --devel \
            && pipu \
            && vi +PlugUpgrade +PlugUpdate +qa
    }
fi
# }}}
# }}}
