#!/bin/bash
machine_type=$(get_machine_type)

function SetupNginx() {
    AddPackage nginx
    CreateLink /etc/systemd/system/multi-user.target.wants/nginx.service /usr/lib/systemd/system/nginx.service
    CopyFile /etc/nginx/nginx.conf
    IgnorePath '/etc/nginx/conf.d'     # secret
    IgnorePath '/etc/nginx/htpasswd'   # secret
    IgnorePath '/etc/nginx/ssl-config' # secret

    AddPackage goaccess

    # Certbot
    AddPackage certbot
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
}

# Server packages
if [[ "$machine_type" == "server" ]]; then
    AddPackage kitty-terminfo

    SetupNginx

    # mkinitcpio for ssh on boot
    AddPackage mkinitcpio-netconf
    AddPackage mkinitcpio-tinyssh
    AddPackage mkinitcpio-utils

    # Firewall
    AddPackage ufw

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
    CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
    CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service
    CreateLink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service /usr/lib/systemd/system/systemd-networkd-wait-online.service
    CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket

    CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
    CreateLink /etc/systemd/system/multi-user.target.wants/ufw.service /usr/lib/systemd/system/ufw.service

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
fi
