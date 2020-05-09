FROM balenalib/raspberrypi3

ENV container docker
# Install other apt deps
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  curl \
  dbus \
  wget \
  xserver-xorg-core \
  xserver-xorg-legacy \
  xserver-xorg-input-all \
  xserver-xorg-video-fbdev \
  x11-xserver-utils \
  xorg \
  chromium-browser \
  libxcb-image0 \
  libxcb-util0 \
  xdg-utils \
  libdbus-1-dev \
  libcap-dev \
  libxtst-dev \
  libxss1 \
  lsb-release \
  fbset \
  systemd-sysv \
  libexpat-dev && rm -rf /var/lib/apt/lists/*

RUN echo "#!/bin/bash" > /etc/X11/xinit/xserverrc \
  && echo "" >> /etc/X11/xinit/xserverrc \
  && echo 'exec /usr/bin/X -s 0 dpms -nocursor -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc

# We never want these to run in a container
# Feel free to edit the list but this is the one we used
RUN systemctl mask \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \
    display-manager.service \
    getty@.service \
    systemd-logind.service \
    systemd-remount-fs.service \
    getty.target \
    graphical.target

COPY entry.sh /usr/bin/entry.sh
COPY balena.service /etc/systemd/system/balena.service

RUN systemctl enable /etc/systemd/system/balena.service

STOPSIGNAL 37
ENTRYPOINT ["/usr/bin/entry.sh"]
ENV INITSYSTEM on
ENV UDEV on

# Setting up the user application
WORKDIR /usr/src/app
COPY start.sh .

# Start app
CMD ["bash", "start.sh"]