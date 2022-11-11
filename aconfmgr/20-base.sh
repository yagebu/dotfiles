#!/bin/bash

# Base packages
AddPackage base
AddPackageGroup base-devel
AddPackage filesystem
AddPackage linux
AddPackage linux-firmware
AddPackage arch-install-scripts
AddPackage intel-ucode # Microcode update files for Intel CPUs

# Base packages: package management
AddPackage --foreign aconfmgr-git
AddPackage --foreign downgrade
AddPackage --foreign pikaur

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
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service

# Load user ZSH config from .config/zsh
# /etc/zsh/zshenv
echo 'export ZDOTDIR="$HOME/.config/zsh/"' >"$(CreateFile /etc/zsh/zshenv)"

# /etc/locale.gen
f="$(GetPackageOriginalFile glibc /etc/locale.gen)"
sed -i 's/^#\(de_DE.UTF-8\)/\1/g' "$f"
sed -i 's/^#\(en_GB.UTF-8\)/\1/g' "$f"
sed -i 's/^#\(en_US.UTF-8\)/\1/g' "$f"

# /etc/locale.conf
echo 'LANG=en_GB.utf8' >"$(CreateFile /etc/locale.conf)"

# systemd-resolv als DNS resolver
CreateLink /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service
