.PHONY: user
user: deps
	mkdir -p ~/.config/zsh
	cp deps/dircolors ~/.config/zsh/dircolors
	cp shell/zprofile.zsh ~/.config/zsh/.zprofile
	cat deps/completion shell/zshrc.zsh shell/zsh-aliases.zsh > ~/.config/zsh/.zshrc

	mkdir -p ~/.local/bin
	cp bin/bak ~/.local/bin/bak

	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/{conf.d,functions}
	cp shell/config.fish ~/.config/fish/config.fish
	cp shell/functions/*.fish ~/.config/fish/functions
	cp shell/abbreviations.fish ~/.config/fish/conf.d/abbreviations.fish
	fzf --fish > ~/.config/fish/conf.d/generated_fzf.fish
	lua deps/z.lua --init fish > ~/.config/fish/conf.d/generated_zlua.fish
	dircolors -c deps/dircolors > ~/.config/fish/conf.d/generated_dircolors.fish

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
	-kitten themes --dump-theme "Gruvbox Dark" > ~/.config/kitty/current-theme.conf

.PHONY: aconfmgr-save
aconfmgr-save:
	aconfmgr -c aconfmgr --skip-checksums save

.PHONY: aconfmgr-apply
aconfmgr-apply:
	aconfmgr -c aconfmgr --skip-checksums apply

.PHONY: nvim
nvim: user
	nvim +PlugUpgrade +PlugClean! +PlugUpdate +qa

.PHONY: system
system: nvim
	paru
	-sudo bootctl update
	-flatpak update
	-flatpak uninstall --unused
	aconfmgr -c aconfmgr --skip-checksums apply

deps:
	mkdir -p deps
	curl -o deps/dircolors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
	curl -o deps/completion https://raw.githubusercontent.com/twe4ked/dotfiles/master/shell/zsh/completion.zsh
	curl -o deps/z.lua https://raw.githubusercontent.com/skywind3000/z.lua/master/z.lua

.PHONY: clean
clean:
	rm -r deps
