mv ~/.inputrc ~/.inputrc-original 2>/dev/null

#mv ~/.profile ~/.profile-original 2>/dev/null
#ln -s dotfiles/.profile
#ln -s dotfiles/.xmodmap

ln -s dotfiles/.inputrc
ln -s dotfiles/.tmux.conf 
ln -s dotfiles/.gitconfig
ln -s dotfiles/.gitignore
ln -s dotfiles/.bash_aliases


ln -s dotfiles/.vimrc
ln -s dotfiles/.vim/


#Note this doesnt link up .ssh/config or .config/xfce4

#
#UBU ONLY, just cut and paste the following:
#
#sudo apt install git vim htop vim-gnome tmux 
#sudo apt install fbreader iftop netstat
