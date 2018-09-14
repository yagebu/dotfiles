These dotfiles put most files in `~/.config` so that the home directory is nice
and clean. The following should be added to `/etc/zsh/zshenv` so that zsh finds
its config.

    export ZDOTDIR="$HOME/.config/zsh/"

To install the files, run `./install download` (which dowloads some
dependencies from Github). On changes, run `install` to copy over the changes
files.

## Desktop Environment

I'm currently using sway as window manager.  Suspend/resume is handled by
systemd and default settings. TLP for energy saving. NetworkManager for
wifi. SDDM as login manager. swaylock provides the lockscreen and is started by
systemd.

## Other programs

* Browser: Firefox with vimium.
* Email: mutt, offlineimap, and msmtp
* Media player: mpv.
* PDF: zathura with mupdf backend.
* Music: cmus as player and beets for management.

## Keyboard layout

US AltGr-International seems to be the best. Has no dead keys but all necessary
umlaute and even french accents can be typed easily in combination with the
AltGr key. If not available (Gnome doesn't seem to have it), US International
seems to be a good alternative, which is the same with dead keys.  Also set
Capslock to be another Ctrl key.

    localectl set-x11-keymap us pc105 altgr-intl 'ctrl:nocaps'
