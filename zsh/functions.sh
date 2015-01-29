cleanup () {
	echo -e "\e[1;34m::\e[0m Cleaning pacman cache..."
	sudo rm /var/cache/pacman/pkg/* &> /dev/null

	echo -e "\e[1;34m::\e[0m Deleting unneeded files..."
	rm -rf ~/.adobe
	rm -rf ~/.cache/chromium
	rm -rf ~/.config/chromium/Default/Pepper\ Data/
	rm -rf ~/.config/chromium/Default/Local\ Storage/http*
	rm -rf ~/.config/chromium/Default/IndexedDB/http*
	rm -rf ~/.config/chromium/Default/databases/http*
	rm -rf ~/.macromedia
	rm -rf ~/.mozilla
	rm -rf ~/.muttator
	rm -rf ~/.mpv
	rm -rf ~/.local/share/gvfs-metadata
	rm -rf ~/.local/share/loliclip
	rm -rf ~/.local/share/recently-used.xbel
	rm -rf ~/.thumbnails

	echo -e "\e[1;34m::\e[0m Done."
}

backup-external () {
	backup_dir=/run/media/jakob/Quickstore

	if [ -d $backup_dir ]; then
		echo -e "\e[1;34m::\e[0m Backing up Pictures to Quickstore.."
			rsync -a --delete ~/Pictures/ $backup_dir/Pictures
			echo -e "\e[1;34m::\e[0m Done."
	else
		echo -e "\e[1;31merror:\e[0m backup directory (Quickstore) not found"
	fi

    backup_dir2=/run/media/jakob/BACKUP
    if [ -d $backup_dir2 ]; then
       echo -e "\e[1;34m::\e[0m Backing up everything from Quickstore to WD.."
           rsync -a --delete --progress $backup_dir/ $backup_dir2
           echo -e "\e[1;34m::\e[0m Done."
    else
        echo -e "\e[1;31merror:\e[0m backup directory (WD) not found"
    fi
}
