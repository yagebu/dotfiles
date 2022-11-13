#!/bin/bash
machine_type=$(get_machine_type)

if [[ "$machine_type" == "desktop" ]]; then
    # Fonts
    AddPackage adobe-source-code-pro-fonts
    AddPackage adobe-source-sans-fonts
    AddPackage otf-fira-mono
    AddPackage otf-fira-sans
    AddPackage otf-font-awesome
    AddPackage ttf-droid
    AddPackage ttf-inconsolata
    AddPackage ttf-ubuntu-font-family
    AddPackage --foreign fonts-meta-base
    AddPackage --foreign otf-et-book
    AddPackage --foreign ttf-mac-fonts

    # Font config
    CopyFile /etc/fonts/local.conf
fi
