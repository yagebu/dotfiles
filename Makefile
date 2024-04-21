.PHONY: user
user: deps
	mkdir -p ~/.config/zsh
	cp deps/dircolors ~/.config/zsh/dircolors
	cp zshenv ~/.config/zsh/.zshenv
	cat deps/completion deps/fzf-keys deps/fzf-completion zshrc > ~/.config/zsh/.zshrc

	mkdir -p ~/bin
	cp bin/bak ~/bin/bak

	mkdir -p ~/.config/nvim
	rm -f ~/.config/nvim/init.vim
	cp nvim_init.lua ~/.config/nvim/init.lua

	mkdir -p ~/.config/kitty
	cp arch/kitty.conf ~/.config/kitty/kitty.conf

	mkdir -p ~/.config/sway
	cp arch/sway ~/.config/sway/config

	mkdir -p ~/.config/waybar
	cp arch/waybar ~/.config/waybar/config
	cp arch/waybar.css ~/.config/waybar/style.css

	mkdir -p ~/.config/kitty
	cp arch/kitty.conf ~/.config/kitty/kitty.conf

.PHONY: aconfmgr-save
aconfmgr-save:
	aconfmgr -c aconfmgr --skip-checksums save

.PHONY: aconfmgr-apply
aconfmgr-apply:
	aconfmgr -c aconfmgr --skip-checksums apply

.PHONY: system
system:
	paru
	nvim +PlugUpgrade +PlugClean! +PlugUpdate +qa
	aconfmgr -c aconfmgr --skip-checksums apply

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
