#mv ~/.inputrc ~/.inputrc-original 2>/dev/null
#mv ~/.profile ~/.profile-original 2>/dev/null
#ln -s dotfiles/.profile
#ln -s dotfiles/.xmodmap

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

#sudo apt install git vim htop vim-gnome tmux  mc  dconf-editor
#sudo apt install fbreader iftop netstat

#GNOME:

#gsettings set org.gnome.desktop.wm.preferences raise-on-click false
#gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
#gsettings set org.gnome.desktop.wm.preferences focus-mode 'mouse'


