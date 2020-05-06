#!/bin/bash

# Setup display
pip3 install RPi.GPIO
git clone "https://github.com/pimoroni/hyperpixel4" -b pi3
cd hyperpixel4
./install.sh
hyperpixel4-rotate left
hyperpixel4-init
cd ..
rm -rf hyperpixel4

# echo "gpu_mem=128" >> /boot/config.txt
# Replace gpu_mem value with a larger value so that chromium can run 
sed -i 's/\(gpu_mem=\)\([0-9]*\)/\1128/g' /boot/config.txt

# Appropriately swap the touchscreen to match the rotation of the display 
# applied above
sed -i 's/\(dtoverlay=hyperpixel4\)/\1,touchscreen-swapped-x-y,touchscreen-inverted-x/g' /boot/config.txt

# We're going to swap dhcpd for NetworkManager so we can use wifi-connect
# apt-get update
# apt-get install -y -d network-manager


systemctl stop dhcpcd
systemctl disable dhcpcd

apt-get purge openresolv dhcpcd5

# apt-get install -y network-manager
apt-get clean

# sed -i 's/\(managed=\)\(false\)/\1true/g' /etc/NetworkManager/NetworkManager.conf

systemctl enable NetworkManager
systemctl start NetworkManager

# Start the services
docker-compose up -d