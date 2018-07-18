#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "Run as root!"
   exit 1
fi

echo "bsnyder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
cat <<EOT >>/etc/hosts
192.168.22.43  ine
192.168.22.182 owss
192.168.22.40  tm1
192.168.22.42  tm2
EOT

