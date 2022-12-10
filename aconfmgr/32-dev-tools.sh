#!/bin/bash
machine_type=$(get_machine_type)

# Dev: Editors
AddPackage neovim
AddPackage python-pynvim
AddPackage --foreign neovim-remote
AddPackage stylua   # The config for neovim is written in lua
AddPackage kakoune
if [[ "$machine_type" == "desktop" ]]; then
    AddPackage code
fi

# Dev: Tools
AddPackage ack        # grep-like
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
AddPackage zsh   # Default shell used by this config
AddPackage lua   # For z.lua

# Dev: Javascript, Typescript, Svelte
AddPackage npm                        # A package manager for javascript
AddPackage eslint
AddPackage prettier
AddPackage typescript-language-server # Language Server Protocol (LSP) implementation for TypeScript using tsserver
AddPackage --foreign nodejs-svelte-language-server

# Dev: Rust
AddPackage rust
AddPackage rust-analyzer
AddPackage maturin

# Dev: Python
AddPackage flake8
AddPackage mpdecimal # for Python's decimal
AddPackage mypy
AddPackage pyenv
AddPackage pyright
AddPackage python-black
AddPackage python-build
AddPackage python-flask
AddPackage python-jedi
AddPackage python-pip
AddPackage python-pipenv
AddPackage python-poetry
AddPackage python-pre-commit
AddPackage python-pylint
AddPackage python-pytest
AddPackage python-pytest-cov
AddPackage python-scikit-learn
AddPackage python-setuptools-scm
AddPackage python-sphinx
AddPackage python-tox
AddPackage python-wheel
AddPackage twine
