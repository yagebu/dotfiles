.PHONY: install
install: deps
	mkdir -p ~/.config/zsh
	cp deps/dircolors ~/.config/zsh/dircolors
	cp zshenv ~/.config/zsh/.zshenv
	cat deps/completion deps/fzf-keys deps/fzf-completion zshrc > ~/.config/zsh/.zshrc
	mkdir -p ~/bin
	cp bin/bak ~/bin/bak
	mkdir -p ~/.config/nvim
	cp vimrc ~/.config/nvim/init.vim
	cp bin/pacman-disowned ~/bin/pacman-disowned
	mkdir -p ~/.config/kitty
	cp arch/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/sway
	cp arch/sway ~/.config/sway/config
	mkdir -p ~/.config/waybar
	cp arch/waybar ~/.config/waybar/config
	cp arch/waybar.css ~/.config/waybar/style.css
	mkdir -p ~/.config/kitty
	cp arch/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/i3status
	cp arch/i3status ~/.config/i3status/config

.PHONY: desktop
desktop: install
	sudo cp arch/systemd-units/backup.service /etc/systemd/system
	sudo cp arch/systemd-units/backup.timer /etc/systemd/system
	sudo cp arch/lock-screen /usr/bin/lock-screen
	sudo pacman -S --needed - < packages/arch-packages
	sudo pacman -S --needed - < packages/desktop-packages
	pikaur -S --noconfirm --needed - < packages/desktop-aur-packages

.PHONY: server
server: install
	sudo cp arch/systemd-units/certbot.service /etc/systemd/system
	sudo cp arch/systemd-units/certbot.timer /etc/systemd/system
	sudo pacman -S --needed - < packages/arch-packages
	sudo pacman -S --needed - < packages/server-packages
	pikaur -S --noconfirm --needed - < packages/server-aur-packages

deps:
	mkdir -p deps
	curl -o deps/dircolors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
	curl -o deps/completion https://raw.githubusercontent.com/twe4ked/dotfiles/master/shell/zsh/completion.zsh
	curl -o deps/fzf-keys https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
	curl -o deps/fzf-completion https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
	curl -o deps/z.lua https://raw.githubusercontent.com/skywind3000/z.lua/master/z.lua

.PHONY: clean
clean:
	rm -r deps
