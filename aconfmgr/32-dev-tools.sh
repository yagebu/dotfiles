#!/bin/bash
machine_type=$(get_machine_type)

# Dev: Editors
AddPackage neovim
AddPackage python-pynvim
AddPackage --foreign neovim-remote
AddPackage stylua # The config for neovim is written in lua
AddPackage helix

if [[ "$machine_type" == "desktop" ]]; then
    AddPackage code
fi

# Dev: Tools
AddPackage colordiff  # well, colored diff
AddPackage entr       # Run arbitrary commands when files change
AddPackage fd         # Simple, fast and user-friendly alternative to find
AddPackage fzf        # Command-line fuzzy finder
AddPackage git        # well, git
AddPackage github-cli # github CLI (mostly used to open PRs)
AddPackage less       # pager
AddPackage ripgrep    # rg, even better grep
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage filezilla
fi

# Dev: Shell
AddPackage shfmt # Format shell programs
AddPackage fish  # Default shell for this config now
AddPackage zsh   # Shell previously used by this config
AddPackage lua   # For z.lua

# Dev: Javascript, Typescript, Svelte
AddPackage npm
AddPackage eslint
AddPackage prettier
AddPackage eslint-language-server
AddPackage svelte-language-server
AddPackage typescript-language-server

# Dev: Misc
if [[ "$HOSTNAME" == "js-arch" ]]; then
    # this is a very big package
    AddPackage emscripten
    AddPackage ollama
fi

# Dev: Rust
AddPackage rust
AddPackage rust-analyzer
AddPackage maturin
AddPackage cargo-insta
AddPackage cargo-outdated

# Dev: Python
AddPackage flake8
AddPackage mpdecimal # for Python's decimal
AddPackage mypy
AddPackage pre-commit
AddPackage python-cheroot
AddPackage python-flask
AddPackage python-lsp-server
AddPackage python-pip
AddPackage python-pipenv
AddPackage python-pipx
AddPackage python-pytest
AddPackage python-tox
AddPackage python-wheel
AddPackage ruff
AddPackage twine
AddPackage uv
