mv ~/.inputrc ~/.inputrc-original 2>/dev/null
mv ~/.profile ~/.profile-original 2>/dev/null

ln -s dotfiles/.profile
ln -s dotfiles/.inputrc
ln -s dotfiles/.vimrc
ln -s dotfiles/.screenrc
ln -s dotfiles/.bash_aliases
