#!/usr/bin/env sh

DEVICE_NAME="Razer Razer Mamba Tournament Edition"

for id in $(xinput --list | \
            sed -n "/$DEVICE_NAME.*pointer/s/.*=\([0-9]\+\).*/\1/p")
do
    xinput set-button-map $id 1 2 3 4 5 6 7 8 2
done

