#!/bin/bash
machine_type=$(get_machine_type)

if [[ "$machine_type" == "desktop" ]]; then
    # Fonts
    AddPackage adobe-source-code-pro-fonts
    AddPackage adobe-source-sans-fonts
    AddPackage noto-fonts
    AddPackage otf-fira-mono
    AddPackage otf-fira-sans
    AddPackage otf-font-awesome
    AddPackage ttf-dejavu
    AddPackage ttf-droid
    AddPackage ttf-fira-code
    AddPackage ttf-inconsolata
    AddPackage ttf-liberation
    AddPackage ttf-nerd-fonts-symbols-mono
    AddPackage ttf-ubuntu-font-family
    AddPackage --foreign otf-et-book
    AddPackage --foreign ttf-courier-prime
    AddPackage --foreign ttf-heuristica
    AddPackage --foreign ttf-mac-fonts

    # Font config
    # See https://wiki.archlinux.org/title/Font_configuration for reference.
    # Copy overrides:
    #  - using Fira Code as monospace
    CopyFile /etc/fonts/local.conf

    # Link default configs
    for filename in /usr/share/fontconfig/conf.default/*.conf; do
        CreateLink "/etc/fonts/conf.d/$(basename $filename)" "$filename"
    done
fi
