#!/usr/bin/bash

# By default docker gives us 64MB of shared memory size but to display heavy
# pages we need more.
umount /dev/shm && mount -t tmpfs shm /dev/shm
rm /tmp/.X0-lock &>/dev/null || true

sed -i -e 's/console/anybody/g' /etc/X11/Xwrapper.config
echo "needs_root_rights=yes" >> /etc/X11/Xwrapper.config
dpkg-reconfigure xserver-xorg-legacy

# adding user to run chromium since it will not run as root
useradd chromium -m -s /bin/bash -G root
usermod -a -G root,tty chromium

#create start script for X11
echo "#!/bin/bash" > /home/chromium/xstart.sh
# echo "xset s off -dpms" >> /home/chromium/xstart.sh
echo "chromium-browser --kiosk $URL --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --enable-logging=stderr --v=1 > /var/log/chromium.log 2>&1" >> /home/chromium/xstart.sh

touch /var/log/chromium.log
chown chromium:chromium /var/log/chromium.log

chmod 770 /home/chromium/xstart.sh
chown chromium:chromium /home/chromium/xstart.sh

if which udevadm > /dev/null; then
    set +e # Disable exit on error 
    udevadm control --reload-rules service udev restart udevadm trigger set -e # Re-enable exit on error
fi

# starting chromium as chrome user
su -c 'startx /home/chromium/xstart.sh' chromium