function pipu
    if test -d "$HOME/dev/fava"
        uv tool install  \
            --no-managed-python \
            --with fava-plugins \
            --with fava_investor \
            --with smart_importer \
            --editable "$HOME/dev/fava"
    end
    uv tool upgrade --all
    uv cache prune
    pre-commit gc
end
