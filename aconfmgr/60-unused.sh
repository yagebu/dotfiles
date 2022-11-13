#!/bin/bash

###############################
#CopyFile /etc/modprobe.d/nobt.conf.bak
#blacklist btusb
#blacklist bnep
#blacklist bluetooth
#
###############################
#CopyFile /etc/modprobe.d/iwlwifi.conf.bak
#options iwlwifi bt_coex_active=0
#
###############################
#CopyFile /etc/modules-load.d/virtualbox.conf.bak
#vboxdrv
#
###############################
#CopyFile /etc/systemd/system/lock.service
#CreateLink /etc/systemd/system/sleep.target.wants/lock.service /etc/systemd/system/lock.service
#[Unit]
#Description=Lock session using swaylock
#Before=sleep.target
#
#[Service]
#User=jakob
#ExecStart=/usr/bin/lock-screen
#
#[Install]
#WantedBy=sleep.target
#
################################
#CopyFile /usr/bin/lock-screen 755
# !/usr/bin/env bash
# # handle being called from systemd service
# if [ -z "$XDG_RUNTIME_DIR" ] && [ -z "$SWAYSOCK"]; then
# 	uid=$(id -u $USER)
# 	export XDG_RUNTIME_DIR="/run/user/"$uid"/"
# 	export SWAYSOCK=$(find $XDG_RUNTIME_DIR -iname sway*sock)
# fi
# #swaygrab /home/$USER/.cache/lockscreen.png
# #convert -blur 0x6 /home/$USER/.cache/lockscreen.png /home/$USER/.cache/lockscreen.png

# swaylock
# #swaylock -i /home/$USER/.cache/lockscreen.png
