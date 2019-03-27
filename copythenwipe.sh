#This script is meant to enable a quick dotfiles dump to a server that I no longer what to have git access
#Like a shared server for instance
#Moves my server config over and wipes itself out
#Run me in dotfiles directory ~/dotfiles

mv .inputrc ..
mv .tmux.conf ..
mv .gitconfig ..
mv .gitignore ..
mv .bash_aliases ..
mv .vimrc ..
mv .vim ..


