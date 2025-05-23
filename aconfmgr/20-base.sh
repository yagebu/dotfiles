#!/bin/bash

# Base packages
AddPackage base
AddPackage base-devel
AddPackage linux
AddPackage linux-firmware
AddPackage arch-install-scripts
AddPackage intel-ucode # Microcode update files for Intel CPUs

# Base packages: package management
AddPackage pacman-contrib
AddPackage --foreign aconfmgr-git
AddPackage --foreign downgrade
AddPackage --foreign paru-bin

# Base packages: filesystems
AddPackage btrfs-progs
AddPackage cryptsetup  # Userspace setup tool for transparent encryption of block devices using dm-crypt
AddPackage e2fsprogs   # Ext2/3/4 filesystem utilities
AddPackage exfat-utils # Utilities for exFAT file system
AddPackage gptfdisk    # A text-mode partitioning tool that works on GUID Partition Table (GPT) disks
AddPackage lvm2        # Logical Volume Manager 2 utilities
AddPackage ntfs-3g     # NTFS filesystem driver and utilities
CreateLink /etc/systemd/system/timers.target.wants/btrfs-scrub@-.timer /usr/lib/systemd/system/btrfs-scrub@.timer

# Base config
CreateLink /etc/os-release ../usr/lib/os-release
CopyFile /etc/mkinitcpio.d/linux.preset

# Time zone and time sync
CreateLink /etc/localtime ../usr/share/zoneinfo/Europe/Berlin
CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service

# /etc/pacman.conf - Enable color output and parallel downloads
f="$(GetPackageOriginalFile pacman /etc/pacman.conf)"
sed -i 's/^#Color/Color/g' "$f"
sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 5/g' "$f"

# Weekly clearing of pacman cache (keeps the last 3 versions of packages)
CreateLink /etc/systemd/system/timers.target.wants/paccache.timer /usr/lib/systemd/system/paccache.timer

# Load user ZSH config from .config/zsh
# /etc/zsh/zshenv
echo 'export ZDOTDIR="$HOME/.config/zsh/"' >"$(CreateFile /etc/zsh/zshenv)"

# /etc/locale.gen - Enable locale generation
f="$(GetPackageOriginalFile glibc /etc/locale.gen)"
sed -i 's/^#\(de_DE.UTF-8\)/\1/g' "$f"
sed -i 's/^#\(en_GB.UTF-8\)/\1/g' "$f"
sed -i 's/^#\(en_US.UTF-8\)/\1/g' "$f"

# Set XDG base directories, see https://wiki.archlinux.org/title/XDG_Base_Directory
cat >>"$(GetPackageOriginalFile pam /etc/security/pam_env.conf)" <<EOF
BROWSER                DEFAULT=firefox
EDITOR                 DEFAULT=nvim
LESSHISTFILE           DEFAULT=-
XDG_CACHE_HOME         DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME        DEFAULT=@{HOME}/.config
XDG_DATA_HOME          DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME         DEFAULT=@{HOME}/.local/state
npm_config_cache       DEFAULT=@{HOME}/.cache/npm
MYPY_CACHE_DIR         DEFAULT=@{HOME}/.cache/mypy
EOF

# /etc/vconsole.conf
echo 'KEYMAP=us-acentos' >"$(CreateFile /etc/vconsole.conf)"

# /etc/locale.conf
echo 'LANG=en_GB.utf8' >"$(CreateFile /etc/locale.conf)"

cat >"$(CreateFile /etc/shells)" <<EOF
/bin/sh
/bin/bash
/bin/fish
/bin/zsh
/usr/bin/zsh
/usr/bin/git-shell
EOF

# These seem to be changed somehow
SetFileProperty /usr/bin/groupmems group groups
SetFileProperty /usr/bin/groupmems mode 2750

# systemd-resolv als DNS resolver
CreateLink /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service

cat >"$(CreateFile /etc/systemd/resolved.conf.d/dns_servers.conf)" <<EOF
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com
DNSOverTLS=yes
Domains=~.
EOF
