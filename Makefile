.PHONY: configs
configs: deps
	fish install.fish configs

.PHONY: aconfmgr-save
aconfmgr-save:
	aconfmgr -c aconfmgr --skip-checksums save

.PHONY: system
system: configs
	paru
	fish install.fish update
	fish --command pipu
	aconfmgr -c aconfmgr --skip-checksums apply

deps:
	mkdir -p deps
	curl -o deps/dircolors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
	curl -o deps/z.lua https://raw.githubusercontent.com/skywind3000/z.lua/master/z.lua

.PHONY: clean
clean:
	rm -r deps
