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
if [ -f "$HOME/Documents/.config/zsh/localrc.zsh" ]; then
    source "$HOME/Documents/.config/zsh/localrc.zsh"
fi

# use rg for fzf and ignore Library path on OS X
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# z.lua
eval "$(lua ~/dev/dotfiles/deps/z.lua --init zsh)"

# Linux {{{
if [[ "$OSTYPE" == "linux-gnu" ]]; then
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
        uv tool upgrade --all
        return 0
    }
fi
# }}}
# }}}
