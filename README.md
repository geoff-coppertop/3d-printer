# 3d-printer

This is a raspberry pi based 3D pritner controller. The raspberry pi is loaded with [Hypriot OS](https://blog.hypriot.com) this allows for the main pieces to be run as docker containers. The docker container that are run on the host are,
  * **X**, is used as the display backend
  * **Chromium**, is used as the display frontend that bridges the X and Octopi/Klipper containers
  * **Octopi, with Klipper**. Acts as the print spool and communicates with the klipper process to run the motion control on the USB connected controller. This container is a composite image of Octopi and Klipper. In the future it would be cleaner if Octopi and Klipper were separate containers connected by a virtual UART.

The host OS has a device tree overlay applied for the Hyperpixel4 rectangular display, touch events for this device should come from evdev.

It's worth noting that I did consider balena.io as a host OS but am bothered by the fact that I'm forced into using all of their tools which have device number limits at the free tier. Overall the solution may be simpler on balena.io because more things are already finished, but I learn more this way. 

## Setup

The Hypriot project provides detailed steps for flashing the micro SD card needed for the raspberry pi. So that I don't forget here are the concise steps,
  1. Install hypriot tools
     ```bash
     curl -LO https://github.com/hypriot/flash/releases/download/2.6.0/flash
     chmod +x flash
     sudo mv flash /usr/local/bin/flash
     ```
  2. Install ancilliary tools
     ```bash
     brew install pv
     brew install awscli
     ```
  3. Flash micro SD card
     ```bash
     flash \
       --userdata ./hypriot/cloud-init.yml \
       --device /dev/disk2 \
       https://github.com/hypriot/image-builder-rpi/releases/download/v1.12.0/hypriotos-rpi-v1.12.0.img.zip
     ```

## References

I learned from others to make this happen and want to acknowledge those websites and projects.

  * Host OS
    * [Hypriot OS - Getting start with Docker on your Raspberry Pi](https://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/)
    * [Random cloud-config for setting up PXE boot I think](https://gist.github.com/dm4tze/d931a0f17645a0f1cc6e14d353109840)
    * [Sensors and data logging with embedded linux](https://www.balena.io/blog/sensors-and-data-logging-with-embedded-linux-the-ultimate-guide-part-1/#dtoverlaycontainerwithdocker)
    * [Hyperpixel 4 - Manual installation](https://github.com/pimoroni/hyperpixel4)
    * [Hyperpixel 4 - Touchscreen support](https://forums.pimoroni.com/t/hyperpixel-4-touchscreen-support/12695)
    * [Hyperpixel 4 - Touch screen dimensions are swapped](https://forums.pimoroni.com/t/hyperpixel-4-touch-screen-dimensions-are-swapped/8198/10)
    * [balena-io/wifi-connect](https://github.com/balena-io/wifi-connect)
  * Web Kiosk
    * [rspi-kiosk](https://github.com/ck99/rspi-kiosk)
    * [Setup Raspberry Pi for kiosk mode](https://die-antwort.eu/techblog/2017-12-setup-raspberry-pi-for-kiosk-mode/)
  * Octopi / Klipper
    * [OctoPrint](https://octoprint.org)
    * [Klipper](https://www.klipper3d.org)