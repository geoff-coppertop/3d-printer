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

sed -i 's+gpu_mem=\d*+gpu_mem=128+g' /boot/config.txt


# Start the services
docker-compose up -d