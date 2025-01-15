function mvd
    set_color green
    echo "Moving PDF and CSV files to inbox"
    if count $HOME/*.{csv,pdf} >/dev/null
        echo "-> moving the following files"
        set_color normal
        ls -l $HOME/*.{csv,pdf}
        mv $HOME/*.{csv,pdf} $HOME/Documents/inbox
    else
        set_color yellow
        echo "-> No files found"
    end
    set_color normal
end
