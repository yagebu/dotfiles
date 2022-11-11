These dotfiles put most files in `~/.config` so that the home directory is nice
and clean. The Makefile can be used to set it all up:

    make

To handle system config and packages (on Arch Linux), this uses aconfmgr. With
the following, the system config from this repo can be applied:

    make system

Or alternatively, to first check which changes would be made, run `make
aconfmgr-save`.

## Desktop Environment

* sway as window manager.
* Suspend/resume is handled by systemd and default settings.
* TLP for energy saving.
* NetworkManager for wifi.
* GDM as login manager.
* swaylock provides the lockscreen and is started by systemd.

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
