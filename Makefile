.PHONY: install
install: deps
	cp deps/dircolors ~/.config/zsh/dircolors
	cp zshenv ~/.config/zsh/.zshenv
	cat deps/completion deps/fzf-keys deps/fzf-completion deps/z zshrc > ~/.config/zsh/.zshrc
	cp bin/cleanup ~/bin/cleanup
	cp bin/bak ~/bin/bak
	cp vimrc ~/.config/nvim/init.vim
	cp bin/backup-arch ~/bin/backup
	cp bin/backup-external ~/bin/backup-external
	cp bin/pacman-disowned ~/bin/pacman-disowned
	cp arch/kitty.conf ~/.config/kitty/kitty.conf
	cp arch/sway ~/.config/sway/config
	cp arch/i3status ~/.config/i3status/config

.PHONY: sudo
sudo: install
	sudo cp arch/lock-screen /usr/bin/lock-screen
	sudo pacman -S --needed - < packages/arch-packages

deps:
	mkdir -p deps
	curl -o deps/dircolors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
	curl -o deps/completion https://raw.githubusercontent.com/twe4ked/dotfiles/master/shell/zsh/completion.zsh
	curl -o deps/fzf-keys https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
	curl -o deps/fzf-completion https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
	curl -o deps/z https://raw.githubusercontent.com/rupa/z/master/z.sh

.PHONY: clean
clean:
	rm -r deps
