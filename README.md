# 3d-printer

Klipper based #d printer. My goals are a printer that,
1. Can be setup reliably
2. Can be used without a computer
3. Can be controlled from a computer

## Setup

### OS

The Big Tree Tech Pi2 is a cheapish alternative to the Raspberry Pi 3/4. The [user manul](https://github.com/bigtreetech/CB2) for the BTT Pi2/CB2 details how to install armbian from which we can the run a series of steps to setup the printer with Klipper in a consistent manner.

### Things that make it a printer

We need to install the following things to make it the way I like. I'm not good at following instructions, even the ones I write, so we will try and make choices that allow us to engineer our way out of having to read.

#### Klipper

https://github.com/Klipper3d/klipper

#### Moonraker

https://github.com/Arksine/moonraker

#### Katapult

https://github.com/Arksine/katapult

#### Mainsail

https://github.com/mainsail-crew/mainsail

#### Klipper Screen

https://github.com/jordanruthe/KlipperScreen

#### KAMP

ttps://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging

#### Klipper Backup

https://github.com/Staubgeborener/klipper-backup
https://klipperbackup.xyz/

#### Crowsnest

https://github.com/mainsail-crew/crowsnest

#### Mainsail Config

https://github.com/mainsail-crew/mainsail-config

#### Sonar

https://github.com/mainsail-crew/sonar

#### Moonraker Timelapse

https://github.com/mainsail-crew/moonraker-timelapse

#### Mooncord

https://github.com/eliteSchwein/mooncord

#### Printer Configuration

https://github.com/geoff-coppertop/printer-macros
https://github.com/geoff-coppertop/cr6-config

#### Cartographer 3D

https://github.com/Cartographer3D/cartographer-klipper

### Build firmware


### CAN Networking

https://canbus.esoterical.online/
https://github.com/Esoterical/voron_canbus

### IP Networking

```
[Unit]
Description=Klipper Backup On-boot Service
#Uncomment below lines if using network manager
#After=NetworkManager-wait-online.service
#Wants=NetworkManager-wait-online.service
#Uncomment below lines if not using network manager
#After=network-online.target
#Wants=network-online.target

[Service]
User={replace with your username}
Type=oneshot
ExecStart=/usr/bin/env bash -c "/usr/bin/env bash $HOME/klipper-backup/script.sh -c \"New Backup on boot - $(date +\"%%x - %%X\")\""

[Install]
WantedBy=default.target
```

Can we use the NetworkManager-wait-online service to determine if we start a daemon that sets up a WiFi AP that has a captive portal for configuraing station mode?
