# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME"  ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME"   ]] || export XDG_DATA_HOME=$HOME/.local/share

# Change $TERM so that 256 colors are used
[[ "$TERM" = "xterm" ]] && export TERM=xterm-256color

export EDITOR="nvim"
export HISTSIZE=10000
export HISTFILE="$XDG_CONFIG_HOME/zsh/history"
export SAVEHIST=$HISTSIZE
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/nvim/init.vim" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/nvim"
export FRESH_RCFILE="$HOME/dev/dotfiles/freshrc"
export FRESH_PATH="$XDG_CONFIG_HOME/fresh"
export _Z_DATA="$XDG_CONFIG_HOME/zsh/z"
export LESSHISTFILE="$XDG_CONFIG_HOME/lesshst"

if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export LANG=en_US.UTF-8
fi
