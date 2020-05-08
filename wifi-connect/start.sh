#!/usr/bin/env bash

# It takes couple of seconds (or longer) to establish a WiFi connection
# sometimes. In this case, following checks will fail and wifi-connect will be
# launched even if the device will be able to connect to a WiFi network. If this
# is your case, you can wait for a while and then check for the connection.
sleep 15

# Is there Internet connectivity?
wget --spider https://coppertop.ca 2>&1

if [ $? -eq 0 ]; then
    printf 'Skipping WiFi Connect\n'
else
    printf 'Starting WiFi Connect\n'
    ./wifi-connect
fi

# Start your application here.
sleep infinity