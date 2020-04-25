FROM resin/rpi-raspbian:jessie
RUN sudo apt-get update && sudo apt-get install --no-install-recommends -y \
	openbox \
    xserver-xorg \
    xinit \
    xserver-xorg-video-fbdev \
    xinput

COPY x.sh /
CMD ["/x.sh"]