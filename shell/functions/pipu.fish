function pipu
    if test -d "$HOME/dev/fava"
        uv tool install  \
            --with fava-plugins \
            --with fava_investor \
            --with smart_importer \
            --editable "$HOME/dev/fava"
    end
    uv tool upgrade --all
end
