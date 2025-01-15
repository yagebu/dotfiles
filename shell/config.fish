# vim: set foldmethod=marker:

# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

# Many base environment variables are set via pam_env and
# /etc/security/pam_env.conf

# Put user binaries on $PATH
fish_add_path "$HOME/.local/bin"

# Disable greeting message
set -U fish_greeting

# Set up z.lua {{{
# The fish script is generated on install to conf.d
set -x _ZL_DATA "$HOME/.config/fish/zlua_data"
set -x _ZL_CD cd
# }}}

# Dircolors {{{
# The fish script is generated on install to conf.d
#  }}}
