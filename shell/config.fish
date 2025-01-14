# vim: set foldmethod=marker:

# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

# Put user binaries on $PATH
fish_add_path "$HOME/.local/bin"

# Set some basic environment variables {{{
set -x EDITOR "nvim"
set -x BROWSER "firefox"
set -x LESSHISTFILE "-"
# }}}

# Cache directories {{{
set -x npm_config_cache "$XDG_CACHE_HOME/npm"
set -x PYLINTHOME "$XDG_CACHE_HOME/pylintd/"
set -x MYPY_CACHE_DIR "$XDG_CACHE_HOME/mypy/"
# }}}

# No greeting message
set -U fish_greeting

# Set up z.lua {{{
# The fish script is generated on install
set -gx _ZL_DATA "$XDG_CONFIG_HOME/fish/zlua_data"
set -gx _ZL_CD cd
# }}}

# Dircolors {{{
# The fish script is generated on install
#  }}}

function mvd
    mv ~/*.pdf ~/Documents/inbox
    mv ~/*.csv ~/Documents/inbox
end

function pipu
    if test -d "$HOME/dev/fava"
        uv tool install  \
            --with fava-plugins \
            --with fava_investor \
            --with smart_importer \
            --editable "$HOME/dev/fava"
    end
    uv tool upgrade --all
end
