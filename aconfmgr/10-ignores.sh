#!/bin/bash
machine_type=$(get_machine_type)

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
IgnorePath '/etc/passwd'
IgnorePath '/etc/passwd-'
IgnorePath '/etc/shadow'
IgnorePath '/etc/shadow-'
IgnorePath '/etc/sudoers'
IgnorePath '/etc/sudoers-'

# Systemd credstore?
IgnorePath '/etc/credstore'
IgnorePath '/etc/credstore.encrypted'

# Server things
if [[ "$machine_type" == "server" ]]; then
    IgnorePath '/etc/letsencrypt/*'
    # ufw: TODO
    IgnorePath '/etc/ufw/applications.d/custom'
    IgnorePath '/etc/ufw/ufw.conf'
    IgnorePath '/etc/ufw/user.rules'
    IgnorePath '/etc/ufw/user6.rules'
    IgnorePath '/etc/tinyssh/*' # secret
    IgnorePath '/var/lib/nginx/*'
    IgnorePath '/var/lib/letsencrypt'
fi

# IgnorePath '/etc/bluetooth'
# IgnorePath '/etc/brlapi.key'
IgnorePath '/etc/conf.d/lm_sensors'
IgnorePath '/etc/colord'                    # auto-generated
IgnorePath '/etc/cups/subscriptions.conf'   # auto-generated
IgnorePath '/etc/cups/subscriptions.conf.O' # auto-generated
IgnorePath '/etc/cups/printers.conf'        # permissions are changed by cups
IgnorePath '/etc/cups/classes.conf'         # permissions are changed by cups
IgnorePath '/etc/fstab'
IgnorePath '/etc/gnome-remote-desktop'
IgnorePath '/etc/iproute2/rt_tables'
IgnorePath '/etc/ld.so.cache'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/mullvad-vpn/account-history.json' # secret
IgnorePath '/etc/mullvad-vpn/device.json'          # secret
IgnorePath '/etc/mullvad-vpn/settings.json'        # secret
IgnorePath '/etc/nvme/hostid'
IgnorePath '/etc/nvme/hostnqn'
IgnorePath '/etc/printcap'

IgnorePath '/etc/.updated'                            # systemd-generated file
IgnorePath '/etc/ca-certificates/extracted/*'         # extracted ssl certificates
IgnorePath '/etc/ssl/certs/*'                         # extracted ssl certificates
IgnorePath '/etc/ssh/*_key'                           # secret
IgnorePath '/etc/ssh/*_key.pub'                       # secret
IgnorePath '/etc/NetworkManager/system-connections/*' # secret
IgnorePath '/etc/pacman.d/gnupg/*'                    # pacman key stuff

IgnorePath '/etc/udev/hwdb.bin'     # large auto-generated file
IgnorePath '/usr/lib/udev/hwdb.bin' # large auto-generated file

IgnorePath '/usr/share/info/dir'
IgnorePath '/usr/share/mime/*'  # Ignore mime type config
IgnorePath '/usr/lib/modules/*' # linux kernel modules stuff
IgnorePath '/usr/lib/utempter/utempter'

# Ignore stuff in var lib - this should only ignore stuff for installed packages.
IgnorePath '/var/.updated' # systemd-generated file
IgnorePath '/var/lib/AccountsService/*'
IgnorePath '/var/lib/NetworkManager/*'
IgnorePath '/var/lib/bluetooth/*'
IgnorePath '/var/lib/boltd/*'
IgnorePath '/var/lib/btrfs/scrub.status.*'
IgnorePath '/var/lib/colord/*'
IgnorePath '/var/lib/dbus/machine-id'
IgnorePath '/var/lib/dkms/*'
IgnorePath '/var/lib/flatpak/*'
IgnorePath '/var/lib/fprint/*'
IgnorePath '/var/lib/fwupd/*'
IgnorePath '/var/lib/gdm/*'
IgnorePath '/var/lib/logrotate.status'
IgnorePath '/var/lib/ollama'
IgnorePath '/var/lib/pacman/*'
IgnorePath '/var/lib/passim/*'
IgnorePath '/var/lib/systemd/*'
IgnorePath '/var/lib/tlp/*'
IgnorePath '/var/lib/upower/*'

# Empty dirs that are automatically created somehow
IgnorePath '/var/lib/BrlAPI'
IgnorePath '/var/lib/brltty'
IgnorePath '/var/lib/geoclue'
IgnorePath '/var/lib/gnome-remote-desktop'
IgnorePath '/var/lib/lastlog'
IgnorePath '/var/lib/libuuid'
IgnorePath '/var/lib/machines'
IgnorePath '/var/lib/portables'
IgnorePath '/var/lib/private'
IgnorePath '/var/lib/tpm2-tss/system/keystore'

IgnorePath '/var/db/sudo/lectured' # users that were shown the sudo intro lecture message
IgnorePath '/var/log/*'            # Ignore logs
IgnorePath '/var/spool/cups/*'     # Ignore cups files
IgnorePath '/var/tmp/*'            # TMP

# Permissions are changed by some process
IgnorePath '/usr/share/polkit-1/rules.d'

# Cache paths
IgnorePath '/usr/lib/*.cache'
IgnorePath '/usr/lib/locale/locale-archive'
IgnorePath '/usr/share/applications/mimeinfo.cache'
IgnorePath '/usr/share/glib-2.0/schemas/gschemas.compiled'
IgnorePath '/usr/share/icons/Adwaita/icon-theme.cache'
IgnorePath '/usr/share/icons/hicolor/icon-theme.cache'
