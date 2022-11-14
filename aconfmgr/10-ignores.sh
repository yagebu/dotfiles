#!/bin/bash

# Ignore boot partition and swapfile
IgnorePath '/boot/*'
IgnorePath '/swapfile'

# Base UNIX files
IgnorePath '/etc/.pwd.lock'
IgnorePath '/etc/group'
IgnorePath '/etc/group-'
IgnorePath '/etc/gshadow'
IgnorePath '/etc/gshadow-'
IgnorePath '/etc/hostname'
IgnorePath '/etc/hosts'
IgnorePath '/etc/passwd'
IgnorePath '/etc/passwd-'
IgnorePath '/etc/shadow'
IgnorePath '/etc/shadow-'
IgnorePath '/etc/shells'
IgnorePath '/etc/sudoers'
IgnorePath '/etc/sudoers-'

# Server things
IgnorePath '/etc/letsencrypt/*'
IgnorePath '/etc/nginx/*'   # TODO
IgnorePath '/etc/ufw/*'     # TODO
IgnorePath '/etc/tinyssh/*' # secret
IgnorePath '/var/lib/nginx/*'
IgnorePath '/var/lib/letsencrypt'

IgnorePath '/etc/bluetooth'
IgnorePath '/etc/brlapi.key'
IgnorePath '/etc/conf.d/lm_sensors'
IgnorePath '/etc/cups/*'
IgnorePath '/etc/fstab'
IgnorePath '/etc/iproute2/rt_tables'
IgnorePath '/etc/ld.so.cache'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/mullvad-vpn/account-history.json'
IgnorePath '/etc/mullvad-vpn/device.json'
IgnorePath '/etc/mullvad-vpn/settings.json'
IgnorePath '/etc/nvme/hostid'
IgnorePath '/etc/nvme/hostnqn'
IgnorePath '/etc/printcap'
IgnorePath '/etc/sane.d/*'

IgnorePath '/etc/.updated'                            # systemd-generated file
IgnorePath '/etc/ca-certificates/extracted/*'         # extracted ssl certificates
IgnorePath '/etc/ssl/certs/*'                         # extracted ssl certificates
IgnorePath '/etc/ssh/*_key'                           # secret
IgnorePath '/etc/ssh/*_key.pub'                       # secret
IgnorePath '/etc/NetworkManager/system-connections/*' # secret
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/etc/lvm/*'

IgnorePath '/etc/udev/hwdb.bin'     # large auto-generated file
IgnorePath '/usr/lib/udev/hwdb.bin' # large auto-generated file

IgnorePath '/usr/share/info/dir'
IgnorePath '/usr/share/perl5/vendor_perl/XML'
IgnorePath '/var/lib/tlp/rfkill-saved'
IgnorePath '/var/lib/tpm2-tss/system/keystore'

IgnorePath '/usr/share/mime/*'     # Ignore mime type config
IgnorePath '/usr/lib/modules/*'    # linux modules stuff
IgnorePath '/usr/lib/utempter/*'

# Ignore stuff in var lib - this should only ignore stuff for installed packages.
IgnorePath '/var/.updated' # systemd-generated file
IgnorePath '/var/lib/AccountsService/*'
IgnorePath '/var/lib/BrlAPI'
IgnorePath '/var/lib/NetworkManager/*'
IgnorePath '/var/lib/alsa/*'
IgnorePath '/var/lib/bluetooth/*'
IgnorePath '/var/lib/boltd/*'
IgnorePath '/var/lib/brltty'
IgnorePath '/var/lib/btrfs/*'
IgnorePath '/var/lib/colord/*'
IgnorePath '/var/lib/dbus/*'
IgnorePath '/var/lib/dkms/*'
IgnorePath '/var/lib/flatpak/*'
IgnorePath '/var/lib/fwupd/*'
IgnorePath '/var/lib/gdm/*'
IgnorePath '/var/lib/geoclue'
IgnorePath '/var/lib/logrotate.status'
IgnorePath '/var/lib/machines'
IgnorePath '/var/lib/pacman/*'
IgnorePath '/var/lib/portables'
IgnorePath '/var/lib/power-profiles-daemon'
IgnorePath '/var/lib/private'
IgnorePath '/var/lib/rpcbind'
IgnorePath '/var/lib/systemd/*'
IgnorePath '/var/lib/tlp/*'
IgnorePath '/var/lib/upower/*'

IgnorePath '/var/db/sudo/*'        # ??
IgnorePath '/var/log/*'            # Ignore logs
IgnorePath '/var/spool/cups/*'     # Ignore cups files
IgnorePath '/var/tmp/*'            # TMP

# Cache paths
IgnorePath '/usr/lib/*.cache'
IgnorePath '/usr/lib/locale/locale-archive'
IgnorePath '/usr/share/applications/mimeinfo.cache'
IgnorePath '/usr/share/glib-2.0/schemas/gschemas.compiled'
IgnorePath '/usr/share/icons/Adwaita/icon-theme.cache'
IgnorePath '/usr/share/icons/hicolor/icon-theme.cache'
