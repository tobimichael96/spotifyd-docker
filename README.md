# spotifyd-docker

This container starts spotifyd and connects to a local pulseaudio tcp connection.

### Configuration

See https://github.com/Spotifyd/spotifyd to configure spotifyd.

This container just needs two environment variables:

* `PULSE_IP` which is the pulseaudio network tcp endpoint
* `PULSE_COOKIE` which is the pulseaudio cookie


### Sample docker-compose

```
version: '3'
 services:
 spotifyd:
    image: ausraster/spotifyd
    network_mode: "host"
    environment:
      - PULSE_COOKIE=/tmp/pulseaudio.cookie
      - PULSE_IP=192.168.178.6
    volumes:
      - /etc/spotifyd.conf:/etc/spotifyd.conf
```
