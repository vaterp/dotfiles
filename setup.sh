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

####GNOME settings (maybe work on some clones)
#gsettings set org.gnome.desktop.wm.preferences raise-on-click false
#gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
#gsettings set org.gnome.desktop.wm.preferences focus-mode 'mouse'
#gsettings set org.gnome.desktop.wm.preferences auto-raise false
#gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'

#Particular ubuntu apps I like to install on a desktop:
#sudo apt install xubuntu-desktop
#sudo apt install git
#sudo apt install openssh-server
#sudo apt install vim nvim vim-gnome
#sudo apt install wireshark
#sudo apt install htop

#### Notes on machine setup....
#git clone https://github.com/vaterp/bin.git
#git clone -b [freebsd|osx|develop] https://github.com/vaterp/dotfiles.git
#git clone https://github.com/vaterp/help.git

####If not VM but main desktop, want to setup .xmodmap and call it from .profile
#mv ~/.profile ~/.profile-original 2>/dev/null
#ln -s dotfiles/.profile
#ln -s dotfiles/.xmodmap

#If desktop resolution not working, might want to run this command:
#./open-vm-tools restart

