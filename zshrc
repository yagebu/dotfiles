# vim: set foldmethod=marker:

for dir in "$HOME/.local/bin"; do
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
if [ -f "$HOME/Documents/.config/localrc" ]; then
    source "$HOME/Documents/.config/localrc"
fi

# use rg for fzf and ignore Library path on OS X
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# z.lua
eval "$(lua ~/dev/dotfiles/deps/z.lua --init zsh)"

# Aliases {{{
# General {{{
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias :q='clear; exit'
alias cl='clear'
alias df='df -h'
alias di='colordiff'
alias du='du -c -h'
alias grep='grep --color=auto'
alias l='ls -lh'
alias la='ls -lha'
alias ls='ls --hyperlink=auto --color=auto'
alias lsa='ls -a'
alias m='mutt -F ~/.config/mutt/muttrc'
alias r='ranger'
alias sudo='sudo '
alias svi='sudo -e'
alias ta='tmux attach'
alias va='source .venv/bin/activate'
alias vi='nvim'
# }}}
# git {{{
alias g='git '
alias gb='git branch'
alias gco='git commit'
alias gd='git diff'
alias gf='git fetch --all -p'
alias gfu='git commit -a --fixup=HEAD'
alias gdw='git diff --color-words'
alias gl='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph -20'
alias glo='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%an]" --graph'
alias gpl='git pull'
alias gpu='git push'
alias gr='git rebase'
alias gri='git rebase -i'
alias gs='git status'
alias go='git checkout'
# }}}
# Linux {{{
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias log='journalctl -r'
    alias sc='sudo systemctl'
    alias scu='systemctl --user'
    alias jc='journalctl'
    # pacman
    alias pac='pacman '
    alias pacr='sudo pacman -Rs'

    mvd() {
        mv ~/*.pdf ~/Documents/inbox
        mv ~/*.csv ~/Documents/inbox
    }

    pipu() {
        if [ -d "$HOME/dev/fava" ]; then
            uv tool install  \
                --with fava-plugins \
                --with fava_investor \
                --with smart_importer \
                --editable "$HOME/dev/fava"
        fi
        # if [ -d "$HOME/dev/beancount" ] then
        #     pipx install "$HOME/dev/beancount" && pipx inject fava "$HOME/dev/beancount"
        # fi
        # if [ -d "$HOME/dev/fava-plugins" ]; then
        #     pipx inject fava -e "$HOME/dev/fava-plugins"
        # else
        #     pipx inject fava fava-plugins
        # fi
        # if [ -d "$HOME/dev/smart_importer" ]; then
        #     pipx inject fava -e "$HOME/dev/smart_importer"
        # else
        #     pipx inject fava smart-importer
        # fi
        # pipx inject fava fava_investor
        uv tool upgrade --all
        return 0
    }
fi
# }}}
# }}}
