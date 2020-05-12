
FROM balenalib/raspberrypi3

ENV container docker
# Install other apt deps
RUN apt-get update && apt-get install -y --no-install-recommends    \
        systemd-sysv                    \
        dbus                            \
        wget                            \
    && rm -rf /var/lib/apt/lists/*      \
# We never want these to run in a container
# Feel free to edit the list but this is the one we used
    && systemctl mask                   \
        dev-hugepages.mount             \
        sys-fs-fuse-connections.mount   \
        sys-kernel-config.mount         \
        display-manager.service         \
        getty@.service                  \
        systemd-logind.service          \
        systemd-remount-fs.service      \
        getty.target                    \
        graphical.target

COPY entry.sh /usr/bin/entry.sh
COPY app.service /etc/systemd/system/app.service

STOPSIGNAL 37

ENTRYPOINT ["/usr/bin/entry.sh"]

# Setting up the user application
WORKDIR /usr/src/app
COPY start.sh .

RUN apt-get update && apt-get install -y --no-install-recommends    \
        dnsmasq         \
        wireless-tools  \
	&& rm -rf /var/lib/apt/lists/*

RUN curl https://api.github.com/repos/balena-io/wifi-connect/releases/latest -s \
    | grep -hoP 'browser_download_url": "\K.*armv7hf\.tar\.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/src/app/

RUN systemctl enable /etc/systemd/system/app.service

CMD ["bash", "start.sh"]