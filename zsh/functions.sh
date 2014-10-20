c () {
	case $1 in
		awm)		vim ~/.config/awesome/rc.lua ;;
		pacman)		sudoedit /etc/pacman.conf ;;
		local)		vim ~/.localrc && source ~/.localrc ;;
	esac
}

cleanup () {
	echo -e "\e[1;34m::\e[0m Cleaning pacman cache..."
	sudo rm /var/cache/pacman/pkg/* &> /dev/null
	yaourt -Scc --noconfirm &> /dev/null

	echo -e "\e[1;34m::\e[0m Deleting unneeded files..."
	rm -rf ~/.adobe
	rm -rf ~/.config/chromium/Default/Pepper\ Data/
	rm -rf ~/.macromedia
	rm -rf ~/.mozilla
	rm -rf ~/.muttator
	rm -rf ~/.mpv
	rm -rf ~/.cmus/command-history
	rm -rf ~/.cmus/search-history
	rm -rf ~/.lesshst
	rm -rf ~/.local/share/Trash
	rm -rf ~/.local/share/gvfs-metadata
	rm -rf ~/.local/share/loliclip
	rm -rf ~/.local/share/recently-used.xbel
	rm -rf ~/.thumbnails

	echo -e "\e[1;34m::\e[0m Done."
}

backup-external () {
	backup_dir=/run/media/jakob/Media

	echo -e "\e[1;34m::\e[0m Backing up pacman database..."
		pacman -Qqe > ~/Docs/.pklist.txt
		echo -e "\e[1;34m::\e[0m Done."

	if [ -d $backup_dir ]; then
		echo -e "\e[1;34m::\e[0m Backing up Photos to Quickstore.."
			rsync -a --delete /media/Media/Photos/ $backup_dir/Photos
			echo -e "\e[1;34m::\e[0m Done."
	else
		echo -e "\e[1;31merror:\e[0m backup directory (Quickstore) not found"
	fi

    backup_dir2=/run/media/jakob/BACKUP
    if [ -d $backup_dir2 ]; then
       echo -e "\e[1;34m::\e[0m Backing up everything from Quickstore to WD.."
           rsync -a --delete $backup_dir/ $backup_dir2
           echo -e "\e[1;34m::\e[0m Done."
    else
        echo -e "\e[1;31merror:\e[0m backup directory (WD) not found"
    fi
}
