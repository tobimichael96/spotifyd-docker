#!/bin/bash

if [ "${PULSE_IP}" != "" ]; then
  sed -i 's/127.0.0.1/'${PULSE_IP}'/g' /home/spotify/.config/pulse/client.conf
fi

/usr/bin/spotifyd --no-daemon
