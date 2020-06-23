
FROM coppertopgeoff/servicebase:edge

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
        dnsmasq         \
        wireless-tools  \
	&& rm -rf /var/lib/apt/lists/*

RUN curl https://api.github.com/repos/balena-io/wifi-connect/releases/latest -s \
    | grep -hoP 'browser_download_url": "\K.*armv7hf\.tar\.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/app/src/

# Setting up the user application
COPY ./start.sh /usr/app/src/start.sh