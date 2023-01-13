#!/bin/bash
machine_type=$(get_machine_type)

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

    cat >"$(CreateFile /etc/modprobe.d/framework-als-deactivate.conf)" <<EOF
blacklist hid_sensor_hub
EOF
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
    CopyFile /etc/polkit-1/rules.d/51-blueman.rules
    CopyFile /etc/udev/rules.d/80-net-setup-link.rules

    CreateLink /etc/systemd/user/sockets.target.wants/gcr-ssh-agent.socket /usr/lib/systemd/user/gcr-ssh-agent.socket
    CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
    CreateLink /etc/systemd/system/sockets.target.wants/fava.socket /etc/systemd/system/fava.socket
    CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
fi

############################################################################################################
# Base packages: graphics and GUI
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage mesa
    AddPackage xclip
    AddPackage xdg-desktop-portal-wlr
    AddPackage xf86-input-synaptics
fi

# Base packages: network
AddPackage ca-certificates # Common CA certificates (default providers)
AddPackage rsync
AddPackage wget
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage networkmanager
    AddPackage wireless_tools # iwconfig and other tools
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
    AddPackage seahorse
    AddPackage dconf-editor

    CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/gdm.service
    CreateLink /etc/systemd/user/sockets.target.wants/gnome-keyring-daemon.socket /usr/lib/systemd/user/gnome-keyring-daemon.socket
fi

# Desktop Apps
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage chromium
    AddPackage firefox
    AddPackage firefox-i18n-de
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

# Man pages.
AddPackage man-db
AddPackage man-pages
CreateLink /etc/systemd/system/timers.target.wants/man-db.timer /usr/lib/systemd/system/man-db.timer

# Hardware tools
AddPackage fwupd      # Simple daemon to allow session software to update firmware
AddPackage lshw       # A small tool to provide detailed information on the hardware configuration of the machine.
AddPackage lm_sensors # Collection of user space tools for general SMBus access and hardware monitoring
AddPackage nvme-cli   # NVM-Express user space tooling for Linux
CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service

# MISC tools
AddPackage borg          # Deduplicating backup program with compression and authenticated encryption
AddPackage python-llfuse # for borg
AddPackage checksec      # Tool designed to test which standard Linux OS and PaX security features are being used
AddPackage htop          # Interactive process viewer
AddPackage khal          # CLI calendar application build around CalDAV
AddPackage logrotate     # Rotates system logs automatically
AddPackage p7zip         # Command-line file archiver with high compression ratio
AddPackage syncthing     # Open Source Continuous Replication / Cluster Synchronization Thing
AddPackage tmux          # A terminal multiplexer
AddPackage tree          # A directory listing program displaying a depth indented list of files
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage flatpak   # Linux application sandboxing and distribution framework (formerly xdg-app)
    AddPackage keepassxc # Cross-platform community-driven port of Keepass password manager
    AddPackage kitty     # A modern, hackable, featureful, OpenGL-based terminal emulator
fi

# Documents
AddPackage ranger            # Simple, vim-like file manager
AddPackage highlight         # source code highlighter for ranger
AddPackage --foreign stapler # PDf joining and the like
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage zathura           # document viewer
    AddPackage zathura-pdf-mupdf # pdf backend for zathura
fi

# Media: Audio and video
AddPackage beets
AddPackage imagemagick       # for beets thumbnails
AddPackage python-pylast     # A Python interface to Last.fm and Libre.fm
AddPackage python-pyacoustid # Bindings for Chromaprint acoustic fingerprinting and the Acoustid API
AddPackage youtube-dl        # A command-line program to download videos from YouTube.com and a few more sites
AddPackage opusfile          # Library for opening, seeking, and decoding .opus files
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage cmus
    AddPackage mpv
    AddPackage pavucontrol        # PulseAudio Volume Control
    AddPackage pipewire-alsa      # Low-latency audio/video router and processor - ALSA configuration
    AddPackage pipewire-jack      # Low-latency audio/video router and processor - JACK support
    AddPackage pipewire-pulse     # Low-latency audio/video router and processor - PulseAudio replacement
    AddPackage gst-libav          # Multimedia graph framework - libav plugin
    AddPackage libva-intel-driver # VA-API for older laptops
    AddPackage intel-media-driver # VA-API for newer laptops
    CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service
    CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service
    CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
    CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
fi

# Latex
# This downloads tex packages on the fly and avoids having basically
# all packages on the disk all the time.
AddPackage tectonic

# Sway and related packages
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage sway
    AddPackage swaybg
    AddPackage swayidle
    AddPackage swaylock

    AddPackage waybar        # (used instead of i3status)
    AddPackage wl-clipboard  # Command-line copy/paste utilities for Wayland
    AddPackage wofi          # launcher (used instead of dmenu)
    AddPackage pamixer       # Pulseaudio command-line mixer like amixer
    AddPackage brightnessctl # Lightweight brightness control tool
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
    AddPackage tesseract
    AddPackage tesseract-data-deu
    AddPackage tesseract-data-eng
fi
