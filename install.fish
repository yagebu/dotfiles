#!/usr/bin/env fish

function init_dirs
    mkdir -p ~/.config/{fish,kitty,nvim,sway,zsh,waybar}
    mkdir -p ~/.config/fish/{conf.d,functions}
    mkdir -p ~/.local/bin
end

function install_binaries
    echo "Copying binaries (bak)"
    cp bin/bak ~/.local/bin/bak
end

function install_fish
    echo "Copying fish shell configuration"
    cp shell/config.fish ~/.config/fish/config.fish
    cp shell/functions/*.fish ~/.config/fish/functions
    cp shell/abbreviations.fish ~/.config/fish/conf.d/abbreviations.fish
    fzf --fish >~/.config/fish/conf.d/generated_fzf.fish
    lua deps/z.lua --init fish >~/.config/fish/conf.d/generated_zlua.fish
    dircolors -c deps/dircolors >~/.config/fish/conf.d/generated_dircolors.fish
end

function install_kitty
    echo "Copying kitty configuration"
    cp arch/kitty.conf ~/.config/kitty/kitty.conf
    if type -q kitten
        kitten themes --dump-theme "Gruvbox Dark" >~/.config/kitty/current-theme.conf
    end
end


function install_neovim
    echo "Copying neovim configuration"
    if test -f ~/.config/nvim/init.vim
        set_color red
        echo "WARN: init.vim exists - should be deleted"
        set_color normal
    end
    cp nvim_init.lua ~/.config/nvim/init.lua
end

function install_sway
    echo "Copying sway and waybar configuration"
    cp arch/sway ~/.config/sway/config
    cp arch/waybar ~/.config/waybar/config
    cp arch/waybar.css ~/.config/waybar/style.css
end

function install_zsh
    echo "Copying zsh configuration"
    cp deps/dircolors ~/.config/zsh/dircolors
    cp shell/zprofile.zsh ~/.config/zsh/.zprofile
    cat shell/zshrc.zsh shell/zsh-aliases.zsh >~/.config/zsh/.zshrc
end

function configs
    echo "Copying all configs"
    init_dirs
    install_binaries
    install_fish
    install_kitty
    install_neovim
    install_sway
    install_zsh
end

function update_flatpak
    if type -q flatpak
        echo "Update flatpak packages"
        flatpak update
        flatpak uninstall --unused
    else
        echo "SKIPPED: flatpak not present"
    end
end

function update_systemd_boot
    if test -f /boot/EFI/systemd/systemd-bootx64.efi
        echo "Update systemd-boot"
        sudo bootctl update
    else
        echo "SKIPPED: systemd-boot not present"
    end
end

function update
    echo "Updating system"
    update_systemd_boot
    update_flatpak
end


switch $argv[1]
    case configs
        configs
    case update
        update
    case '*'
        echo "No option provided - doing nothing"
end
