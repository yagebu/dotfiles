#!/bin/bash
machine_type=$(get_machine_type)

# Server packages
if [[ "$machine_type" == "server" ]]; then
    AddPackage certbot            # An ACME client
    AddPackage goaccess           # An open source real-time web log analyzer and interactive viewer
    AddPackage kitty-terminfo     # Terminfo for kitty, an OpenGL-based terminal emulator
    AddPackage mkinitcpio-netconf # Archlinux mkinitcpio hook for configuring early userspace networking
    AddPackage mkinitcpio-tinyssh # Archlinux mkinitcpio hook to install and enable the tinyssh daemon in early userspace
    AddPackage mkinitcpio-utils   # Collection of Archlinux mkinitcpio utilities performing various tasks
    AddPackage nginx              # Lightweight HTTP server and IMAP/POP3 proxy server
    AddPackage ufw                # Uncomplicated and easy to use CLI tool for managing a netfilter firewall

    AddPackage --foreign fava

    # Boot loader
    AddPackage grub # GNU GRand Unified Bootloader (2)
    CopyFile /etc/default/grub

    # Network
    cat >"$(CreateFile /etc/systemd/network/wired.network)" <<EOF
[Match]
Name=eth0

[Network]
DHCP=yes
EOF
    cat >"$(CreateFile /etc/systemd/network/wired2.network)" <<EOF
[Match]
Name=en*

[Network]
DHCP=yes
EOF
    CreateLink /etc/systemd/system/dbus-org.freedesktop.network1.service /usr/lib/systemd/system/systemd-networkd.service
    CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service
    CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
    CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service
    CreateLink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service /usr/lib/systemd/system/systemd-networkd-wait-online.service
    CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket

    CreateLink /etc/systemd/system/multi-user.target.wants/nginx.service /usr/lib/systemd/system/nginx.service
    CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
    CreateLink /etc/systemd/system/multi-user.target.wants/ufw.service /usr/lib/systemd/system/ufw.service

    # Certbot
    cat >"$(CreateFile /etc/systemd/system/certbot.service)" <<EOF
[Unit]
Description=Let's Encrypt renewal

[Service]
Type=oneshot
ExecStart=/usr/bin/certbot renew
ExecStartPost=/usr/sbin/systemctl restart nginx.service
EOF
    cat >"$(CreateFile /etc/systemd/system/certbot.timer)" <<EOF
[Unit]
Description=Monthly renewal of Let's Encrypt's certificates

[Timer]
OnCalendar=monthly
Persistent=true

[Install]
WantedBy=timers.target
EOF
    CreateLink /etc/systemd/system/timers.target.wants/certbot.timer /etc/systemd/system/certbot.timer

    # Lektor
    ###############################################3
    cat >"$(CreateFile /etc/systemd/system/lektor-biere.service)" <<EOF
[Unit]
Description=Lektor server (Biere).

[Service]
ExecStart=/usr/bin/pipenv run lektor --language de server --port 5101
WorkingDirectory=/home/jakob/lektor/biere
Restart=on-success
User=jakob

[Install]
WantedBy=default.target
EOF
    CreateLink /etc/systemd/system/default.target.wants/lektor-biere.service /etc/systemd/system/lektor-biere.service
    ###############################################3
    cat >"$(CreateFile /etc/systemd/system/lektor-evaschnitzer.service)" <<EOF
[Unit]
Description=Lektor server (evaschnitzer.de).

[Service]
ExecStart=/usr/bin/pipenv run lektor --language de server --port 5103
WorkingDirectory=/home/jakob/lektor/evaschnitzer.de
Restart=on-success
User=jakob

[Install]
WantedBy=default.target
EOF
    CreateLink /etc/systemd/system/default.target.wants/lektor-evaschnitzer.service /etc/systemd/system/lektor-evaschnitzer.service
    ###############################################3
    cat >"$(CreateFile /etc/systemd/system/lektor-kiv.service)" <<EOF
[Unit]
Description=Lektor server (Kunst im Viehhof).

[Service]
ExecStart=/usr/bin/pipenv run lektor --language de server --port 5100
WorkingDirectory=/home/jakob/lektor/kiv
Restart=on-success
User=jakob

[Install]
WantedBy=default.target
EOF
    CreateLink /etc/systemd/system/default.target.wants/lektor-kiv.service /etc/systemd/system/lektor-kiv.service

# CopyFile /etc/systemd/system/lektor-prinzplusprinz.service
# [Unit]
# Description=Lektor server (prinzplusprinz).
#
# [Service]
# ExecStart=/usr/bin/pipenv run lektor --language de server --port 5102
# WorkingDirectory=/home/jakob/lektor/prinzplusprinz
# Restart=on-success
# User=jakob
#
# [Install]
# WantedBy=default.target
fi
