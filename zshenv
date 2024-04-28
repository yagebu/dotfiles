# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME"  ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME"   ]] || export XDG_DATA_HOME=$HOME/.local/share
[[ -n "$XDG_STATE_HOME"   ]] || export XDG_STATE_HOME=$HOME/.local/state

# Change $TERM so that 256 colors are used
[[ "$TERM" = "xterm" ]] && export TERM=xterm-256color

export EDITOR="nvim"
export BROWSER="firefox"
export HISTSIZE=100000
export HISTFILE="$XDG_CONFIG_HOME/zsh/history"
export SAVEHIST=$HISTSIZE
export _ZL_DATA="$XDG_CONFIG_HOME/zsh/zlua"
export LESSHISTFILE="-"
export HGRCPATH="$XDG_CONFIG_HOME/hgrc"
# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Cache directories
export npm_config_cache="$XDG_CACHE_HOME/npm"
export PYLINTHOME="$XDG_CACHE_HOME/pylintd/"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy/"
