## These dotfiles are managed using fresh

These dotfiles put most files in `.config` so that the home directory is nice
and clean. following should be added to /etc/zsh/zshenv so that zsh finds its
config. The environment for most other programs are the set in
~.config/zsh/.zshenv.

    export ZDOTDIR="$HOME/.config/zsh/"

Since the install script that fresh provides doesn't properly work with keeping
everything in ~/.config/ a manual installation is necessary.

    git clone https://github.com/yagebu/dotfiles.git ~/dev/dotfiles
    git clone https://github.com/freshshell/fresh.git ~/.config/fresh/source/freshshell/fresh
    FRESH_RCFILE=~/dev/dotfiles/freshrc FRESH_PATH=~/.config/fresh ~/.config/fresh/source/freshshell/fresh/bin/fresh

## Desktop Environment

I'm currently using Awesome WM as window manager. Current config is the
mulitcolor theme from the awesome-copycats repo (slightly modified).
Suspend/resume is handled by systemd and default settings.  TLP for energy
saving.  NetworkManager for wifi.  GDM as login manager, since a (minimal)
GNOME is installed too. Slimlock provides the lockscreen and is started by
systemd.

## Other programs

* Browser: Chromium with vimium.
* Email: mutt, offlineimap, and msmtp
* Media player: mpv.
* PDF: zathura with mupdf backend, Skim on OS X.
* Music: cmus as player and beets for management.

## Keyboard layout

US AltGr-International seems to be the best. Has no dead keys but all necessary
umlaute and even french accents can be typed easily in combination with the
AltGr key. If not available (Gnome doesn't seem to have it), US International
seems to be a good alternative, which is the same with dead keys.  Also set
Capslock to be another Ctrl key.

    localectl set-x11-keymap us pc105 altgr-intl 'ctrl:nocaps'

## ASUS UX31A specific things

* The fan turns on for short bursts frequently. Using asus-fancontrol with my
  custom control script. See its repository.
* Use asus-kbd-backlight from the AUR to control the keyboard backlight. The
  key shortcuts have to be added manually
* The acpi_osi entry is necessary for the screen backlight keys and the wifi
  key. Complete grub boot line:

        GRUB_CMDLINE_LINUX='cryptdevice=/dev/sda3:cryptroot i915.enable_rc6=1 pcie_aspm=force drm.vblankoffdelay=1 i915.semaphores=1 acpi_osi="!Windows 2012"'
