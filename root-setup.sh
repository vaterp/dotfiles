#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "Run as root!"
   exit 1
fi

#apt install open-vm-tools git vim openssh-server htop

#If Desktop
#apt install open-vm-tools-desktop xrdp
#vim-gtk3 wireshark


#sudo apt install git vim gvim-gtk htop tmux  mc  dconf-editor
#sudo apt install fbreader iftop netstat

echo "bsnyder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
cat <<EOT >>/etc/hosts
192.168.22.43  ine
192.168.22.182 owss
192.168.22.40  tm1
192.168.22.42  tm2
EOT

