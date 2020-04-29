#!/bin/bash
pkill xinit

sleep 3

sed -i '$d' /home/chromium/xstart.sh

# echo "chromium-browser --kiosk --app=$1  --window-size=$WINDOW_SIZE  --disable-dev-shm-usage --ignore-gpu-blacklist --enable-gpu-rasterization --force-gpu-rasterization  --autoplay-policy=no-user-gesture-required --start-fullscreen" >> /home/chromium/xstart.sh

echo "chromium-browser --kiosk https://coppertop.ca --no-first-run --touch-events=enabled --fast --fast-start --disable-popup-blocking --disable-infobars --disable-session-crashed-bubble --disable-tab-switcher --disable-translate --enable-low-res-tiling" >> /home/chromium/xstart.sh

su -c 'export DISPLAY=:0 && startx /home/chromium/xstart.sh -- -nocursor' - chromium