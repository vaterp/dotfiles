gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.wm.preferences auto-raise false
gsettings set org.gnome.desktop.wm.preferences raise-on-click false
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'

git clone https://github.com/vaterp/dotfiles.git
git clone https://github.com/vaterp/bin.git
git clone https://github.com/vaterp/help.git

sudo apt-get install openssh-server
sudo apt-get install git
sudo apt-get install cvs
sudo apt-get install vim
sudo apt-get install vim-gnome
sudo apt-get install xpad
sudo apt-get install wireshark
sudo apt-get install sysv-rc-conf
sudo apt-get install htop

sudo sed -i "/title_vertical_pad/s/value=\"[0-9]\{1,2\}\"/value=\"0\"/g" /usr/share/themes/Adwaita/metacity-1/metacity-theme-3.xml
