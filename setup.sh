#mv ~/.inputrc ~/.inputrc-original 2>/dev/null

#Setup my main files
ln -s dotfiles/.inputrc
ln -s dotfiles/.tmux.conf 
ln -s dotfiles/.gitconfig
ln -s dotfiles/.gitignore
ln -s dotfiles/.bash_aliases
ln -s dotfiles/.vimrc
ln -s dotfiles/.vim/

#
#UBU ONLY, just cut and paste the following:
#

#sudo apt install git vim gvim-gtk htop tmux  mc  dconf-editor
#sudo apt install fbreader iftop netstat

####GNOME:
#gsettings set org.gnome.desktop.wm.preferences raise-on-click false
#gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
#gsettings set org.gnome.desktop.wm.preferences focus-mode 'mouse'

#dconf dump /org/gnome/ > gnome-backup.txt
#dconf load /org/gnome/ < gnome-backup.txt


#### Notes on machine setup....
#git clone https://github.com/vaterp/bin.git
#git clone -b [freebsd|osx|develop] https://github.com/vaterp/dotfiles.git
#git clone https://github.com/vaterp/help.git

####If not VM but main desktop, want to setup .xmodmap and call it from .profile
#mv ~/.profile ~/.profile-original 2>/dev/null
#ln -s dotfiles/.profile
#ln -s dotfiles/.xmodmap

####Notes on VM that can help
#(Too startup with window size hints, must run vmware-user)
#/usr/lib/vmware-tools/sbin64/vmtoolsd -n vmusr --blockFd 3
#sudo /etc/init.d/vmware-tools status
#sudo /etc/init.d/vmware-tools restart
#sleep 3
#/usr/bin/vmware-user
