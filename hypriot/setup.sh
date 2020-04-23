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

# Start the services
docker-compose up -d