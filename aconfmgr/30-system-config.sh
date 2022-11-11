#!/bin/bash
machine_type=$(get_machine_type)
build_size=$(get_build_size)

CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket
CreateLink /etc/systemd/system/multi-user.target.wants/syncthing@jakob.service /usr/lib/systemd/system/syncthing@.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target

############################################################################################################
# Machine specifics

#######################################
if [[ "$HOSTNAME" == "js-arch" ]]; then
    # Mullvad VPN client
    AddPackage --foreign mullvad-vpn
    CreateLink /etc/systemd/system/multi-user.target.wants/mullvad-daemon.service /usr/lib/systemd/system/mullvad-daemon.service
    CreateLink /etc/systemd/system/mullvad-daemon.service.wants/mullvad-early-boot-blocking.service /usr/lib/systemd/system/mullvad-early-boot-blocking.service

    # Backup - only on the main machine
    cat >"$(CreateFile /etc/systemd/system/backup.service)" <<EOF
[Unit]
Description=Backup
Requires=network.target
After=network.target

[Service]
User=jakob
ExecStart=/usr/bin/python3 /home/jakob/bin/bak home
EOF
    cat >"$(CreateFile /etc/systemd/system/backup.timer)" <<EOF
[Unit]
Description=Daily timer for backup

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF
    CreateLink /etc/systemd/system/timers.target.wants/backup.timer /etc/systemd/system/backup.timer

#######################################
elif [[ "$HOSTNAME" == "js-zen" ]]; then
    AddPackage --foreign asus-kbd-backlight
    CreateLink /etc/systemd/system/multi-user.target.wants/asus-kbd-backlight.service /usr/lib/systemd/system/asus-kbd-backlight.service

    # Wifi drivers that use dkms
    AddPackage broadcom-wl-dkms
    AddPackage linux-headers # for DKMS

#######################################
elif [[ "$HOSTNAME" == "js-atom" ]]; then
    cat >>"$(GetPackageOriginalFile systemd /etc/systemd/journald.conf)" <<EOF
SystemMaxUse=250M
RuntimeMaxUse=100M
EOF
    echo 'Server = https://archlinux.mailtunnel.eu/$repo/os/$arch' >"$(CreateFile /etc/pacman.d/mirrorlist)"
    cat >"$(CreateFile /etc/mkinitcpio.conf)" <<EOF
MODULES=()
BINARIES=()
FILES=()
HOOKS=(base udev autodetect modconf block netconf tinyssh encryptssh filesystems keyboard fsck)
EOF
fi

############################################################################################################
# Base desktop config
if [[ "$machine_type" == "desktop" ]]; then
    echo 'Server = https://mirror.f4st.host/archlinux/$repo/os/$arch' >"$(CreateFile /etc/pacman.d/mirrorlist)"
    echo 'KEYMAP=us-acentos' >"$(CreateFile /etc/vconsole.conf)"

    CopyFile /etc/X11/xorg.conf.d/00-keyboard.conf
    CopyFile /etc/X11/xorg.conf.d/10-synaptics.conf
    CopyFile /etc/X11/xorg.conf.d/99-fonts-custom.conf
    CopyFile /etc/environment

    ## Systemd
    # Limit journal disk usage
    cat >>"$(GetPackageOriginalFile systemd /etc/systemd/journald.conf)" <<EOF
SystemMaxUse=250M
EOF
    # Suspend on power key
    cat >>"$(GetPackageOriginalFile systemd /etc/systemd/logind.conf)" <<EOF
HandlePowerKey=suspend
EOF

    cat >"$(CreateFile /etc/mkinitcpio.conf)" <<EOF
MODULES=()
BINARIES=()
FILES=()
HOOKS=(base udev encrypt lvm2 modconf block filesystems keyboard fsck)
EOF

    # Misc config
    CopyFile /etc/fonts/local.conf
    CopyFile /etc/polkit-1/rules.d/51-blueman.rules
    CopyFile /etc/udev/rules.d/80-net-setup-link.rules
    CopyFile /usr/bin/lock-screen 755

    CreateLink /etc/systemd/user/sockets.target.wants/gcr-ssh-agent.socket /usr/lib/systemd/user/gcr-ssh-agent.socket
    CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
    CreateLink /etc/systemd/system/sockets.target.wants/fava.socket /etc/systemd/system/fava.socket
    CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
fi

############################################################################################################
# Base packages: graphics and GUI
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage mesa                   # An open-source implementation of the OpenGL specification
    AddPackage xclip                  # Command line interface to the X11 clipboard
    AddPackage xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    AddPackage xf86-input-synaptics   # Synaptics driver for notebook touchpads
    AddPackage xf86-video-intel       # X.org Intel i810/i830/i915/945G/G965+ video drivers
    AddPackage xf86-video-vesa        # X.org vesa video driver
fi

# Base packages: network
AddPackage ca-certificates # Common CA certificates (default providers)
AddPackage iperf           # A tool to measure maximum TCP bandwidth
AddPackage dhcpcd          # RFC2131 compliant DHCP client daemon
AddPackage openssh
AddPackage rsync
AddPackage wget
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage networkmanager
    AddPackage wireless_tools # Tools allowing to manipulate the Wireless Extensions
    AddPackage iw             # nl80211 based CLI configuration utility for wireless devices
    AddPackage wpa_supplicant # A utility providing key negotiation for WPA wireless networks
    CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
    CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
    CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service

    # Bluetooth
    AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
    CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
    CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service
fi

# GNOME
if [[ "$machine_type" == "desktop" ]]; then
    AddPackageGroup gnome
    AddPackage gnome-tweaks
    AddPackage seahorse     # GNOME application for managing PGP keys.
    AddPackage dconf-editor # GSettings editor for GNOME

    CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/gdm.service
    CreateLink /etc/systemd/user/sockets.target.wants/gnome-keyring-daemon.socket /usr/lib/systemd/user/gnome-keyring-daemon.socket
fi

# Desktop Apps
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage chromium
    AddPackage firefox
    AddPackage firefox-i18n-de
    AddPackage libreoffice-still # LibreOffice maintenance branch
fi

# Printing
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage cups     # The CUPS Printing System - daemon package
    AddPackage cups-pdf # PDF printer for cups
    CreateLink /etc/systemd/system/printer.target.wants/org.cups.cupsd.service /usr/lib/systemd/system/org.cups.cupsd.service
    CreateLink /etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket /usr/lib/systemd/system/org.cups.cupsd.socket
fi

# Laptop things
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage acpi          # Client for battery, power, and thermal readings
    AddPackage powertop      # A tool to diagnose issues with power consumption and power management
    AddPackage tlp           # Linux Advanced Power Management
    AddPackage ethtool       # for tlp Utility for controlling network drivers and hardware
    AddPackage smartmontools # Control and monitor S.M.A.R.T. enabled ATA and SCSI Hard Drives

    CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
    CreateLink /etc/systemd/system/sleep.target.wants/tlp-sleep.service /usr/lib/systemd/system/tlp-sleep.service
fi

# MISC tools
AddPackage ack           # A Perl-based grep replacement, aimed at programmers with large trees of heterogeneous source code
AddPackage borg          # Deduplicating backup program with compression and authenticated encryption
AddPackage python-llfuse # for borg
AddPackage checksec      # Tool designed to test which standard Linux OS and PaX security features are being used
AddPackage colordiff     # A Perl script wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting
AddPackage encfs         # Encrypted filesystem in user-space
AddPackage fd            # Simple, fast and user-friendly alternative to find
AddPackage fwupd         # Simple daemon to allow session software to update firmware
AddPackage gocryptfs     # Encrypted overlay filesystem written in Go.
AddPackage highlight     # Fast and flexible source code highlighter (CLI version)
AddPackage htop          # Interactive process viewer
AddPackage kakoune       # Multiple-selection, UNIX-flavored modal editor
AddPackage khal          # CLI calendar application build around CalDAV
AddPackage lm_sensors    # Collection of user space tools for general SMBus access and hardware monitoring
AddPackage logrotate     # Rotates system logs automatically
AddPackage lshw          # A small tool to provide detailed information on the hardware configuration of the machine.
AddPackage lsof          # Lists open files for running Unix processes
AddPackage lua
AddPackage man-db    # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage nvme-cli  # NVM-Express user space tooling for Linux
AddPackage p7zip     # Command-line file archiver with high compression ratio
AddPackage ranger    # Simple, vim-like file manager
AddPackage --foreign stapler
AddPackage syncthing  # Open Source Continuous Replication / Cluster Synchronization Thing
AddPackage tmux       # A terminal multiplexer
AddPackage tree       # A directory listing program displaying a depth indented list of files
AddPackage youtube-dl # A command-line program to download videos from YouTube.com and a few more sites
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
    AddPackage flatpak   # Linux application sandboxing and distribution framework (formerly xdg-app)
    AddPackage keepassxc # Cross-platform community-driven port of Keepass password manager
    AddPackage kitty     # A modern, hackable, featureful, OpenGL-based terminal emulator
fi
CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service

# Audio and video
AddPackage beets
AddPackage imagemagick       # for beets thumbnails
AddPackage python-pylast     # A Python interface to Last.fm and Libre.fm
AddPackage python-pyacoustid # Bindings for Chromaprint acoustic fingerprinting and the Acoustid API
AddPackage opusfile          # Library for opening, seeking, and decoding .opus files
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage alsa-utils
    AddPackage cmus
    AddPackage mpv
    AddPackage pamixer            # Pulseaudio command-line mixer like amixer
    AddPackage pavucontrol        # PulseAudio Volume Control
    AddPackage pipewire-alsa      # Low-latency audio/video router and processor - ALSA configuration
    AddPackage pipewire-jack      # Low-latency audio/video router and processor - JACK support
    AddPackage pipewire-pulse     # Low-latency audio/video router and processor - PulseAudio replacement
    AddPackage gst-libav          # Multimedia graph framework - libav plugin
    AddPackage libva-intel-driver # VA-API implementation for Intel G45 and HD Graphics family
    CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service
    CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service
    CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
    CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
fi

# Latex
if [[ "$build_size" == "full" ]]; then
    AddPackageGroup texlive-most
fi

# Sway and related packages
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage i3status
    AddPackage sway
    AddPackage swaybg
    AddPackage swayidle
    AddPackage swaylock
    AddPackage waybar
    AddPackage dmenu         # Generic menu for X
    AddPackage wl-clipboard  # Command-line copy/paste utilities for Wayland
    AddPackage wofi          # launcher for wlroots-based wayland compositors
    AddPackage brightnessctl # Lightweight brightness control tool
fi

# Fonts
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage adobe-source-code-pro-fonts
    AddPackage adobe-source-sans-fonts
    AddPackage fontconfig # Library for configuring and customizing font access
    AddPackage freetype2  # Font rasterization library
    AddPackage otf-fira-mono
    AddPackage otf-fira-sans
    AddPackage otf-font-awesome
    AddPackage ttf-droid
    AddPackage ttf-inconsolata
    AddPackage ttf-ubuntu-font-family
    # TODO: this seems to be broken currently:
    # AddPackage --foreign fonts-meta-extended-lt
    AddPackage --foreign fonts-meta-base
    AddPackage --foreign otf-et-book
    AddPackage --foreign ttf-mac-fonts
fi

# Pictures
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage darktable
    AddPackage digikam
    AddPackage displaycal
    AddPackage feh # Fast and light imlib2-based image viewer
    AddPackage --foreign hdrmerge
    AddPackage hugin
    AddPackage rawtherapee
fi

# Dev: neovim
AddPackage neovim
AddPackage python-pynvim # Python client for Neovim
AddPackage --foreign neovim-remote

# Dev: Tools
AddPackage cmake     # A cross-platform open-source make system
AddPackage ctags     # Generates an index file of language objects found in source files
AddPackage diffutils # Utility programs used for creating patch files
AddPackage entr      # Run arbitrary commands when files change
AddPackage fzf       # Command-line fuzzy finder
AddPackage git
AddPackage github-cli
AddPackage less  # A terminal based program for viewing text files
AddPackage meson # High productivity build system
AddPackage ripgrep
AddPackage shfmt # Format shell programs
AddPackage zsh
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage code # The Open Source build of Visual Studio Code (vscode) editor
    AddPackage filezilla
    AddPackage zathura
    AddPackage zathura-pdf-mupdf
fi

# Dev: Javascript, Typescript, Svelte
AddPackage npm                        # A package manager for javascript
AddPackage typescript-language-server # Language Server Protocol (LSP) implementation for TypeScript using tsserver
AddPackage --foreign nodejs-svelte-language-server

# Dev: Rust
AddPackage rust
AddPackage rust-analyzer
AddPackage maturin

# Dev: Python
AddPackage flake8
AddPackage mpdecimal # for Python's decimal
AddPackage mypy
AddPackage pyenv
AddPackage pyright
AddPackage python-black
AddPackage python-build
AddPackage python-flask
AddPackage python-jedi
AddPackage python-pip
AddPackage python-pipenv
AddPackage python-poetry
AddPackage python-pre-commit
AddPackage python-pylint
AddPackage python-pytest
AddPackage python-pytest-cov
AddPackage python-scikit-learn
AddPackage python-setuptools-scm
AddPackage python-sphinx
AddPackage python-tox
AddPackage python-wheel
AddPackage twine # Collection of utilities for interacting with PyPI

# Mail
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage isync          # IMAP and MailDir mailbox synchronizer
    AddPackage lynx           # A text browser for the World Wide Web
    AddPackage msmtp          # A mini smtp client
    AddPackage mutt           # Small but very powerful text-based mail client
    AddPackage python-keyring # Store and access your passwords safely
    AddPackage urlscan        # Mutt and terminal url selector
    AddPackage w3m            # Text-based Web browser as well as pager
fi

# ocrmypdf
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage --foreign ocrmypdf
    AddPackage tesseract          # An OCR program
    AddPackage tesseract-data-deu # Tesseract OCR data (deu)
    AddPackage tesseract-data-eng # Tesseract OCR data (eng)
fi
