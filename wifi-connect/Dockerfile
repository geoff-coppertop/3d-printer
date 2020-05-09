
FROM balenalib/raspberrypi3

RUN install_packages    \
    dnsmasq             \
    wireless-tools      \
    dbus

WORKDIR /usr/src/app

RUN curl https://api.github.com/repos/balena-io/wifi-connect/releases/latest -s \
    | grep -hoP 'browser_download_url": "\K.*armv7hf\.tar\.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/src/app/

COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
ENV INITSYSTEM on

COPY start.sh .

CMD ["bash", "start.sh"]