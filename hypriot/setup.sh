#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

# Setup display
pip3 install RPi.GPIO
git clone "https://github.com/pimoroni/hyperpixel4" -b pi3
cd hyperpixel4
./install.sh
hyperpixel4-rotate left
hyperpixel4-init
cd ..
rm -rf hyperpixel4

# Replace gpu_mem value with a larger value so that chromium can run 
sed -i 's/\(gpu_mem=\)\([0-9]*\)/\1128/g' /boot/config.txt

# Appropriately swap the touchscreen to match the rotation of the display 
# applied above
sed -i 's/\(dtoverlay=hyperpixel4\)/\1,touchscreen-swapped-x-y,touchscreen-inverted-x/g' /boot/config.txt

# We're going to swap dhcpd for NetworkManager so we can use wifi-connect to get
# our networking on in a dynamic way
apt-get update
apt-get install -y -d --no-install-recommends network-manager

systemctl stop dhcpcd
systemctl disable dhcpcd

apt-get purge -y openresolv dhcpcd5

apt-get install -y  --no-install-recommends network-manager
apt-get clean

# Change the interfaces file so that NetworkManager can control all the things
mv /etc/network/interfaces /etc/network/interfaces.bak

sed -i 's/\(managed=\)true/\1false/g' /etc/NetworkManager/NetworkManager.conf

echo "auto lo" > /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces

systemctl enable NetworkManager
systemctl start NetworkManager

# Start the services
su -c 'docker-compose up -d' thomasga
