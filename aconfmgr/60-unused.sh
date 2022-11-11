#!/bin/bash

#CopyFile /etc/modprobe.d/nobt.conf.bak
#blacklist btusb
#blacklist bnep
#blacklist bluetooth
#
#CopyFile /etc/modprobe.d/iwlwifi.conf.bak
#options iwlwifi bt_coex_active=0
#
#CopyFile /etc/modules-load.d/virtualbox.conf.bak
#vboxdrv
#
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
