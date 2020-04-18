FROM rust:stretch as build

ARG BRANCH=master

WORKDIR /usr/src/spotifyd

RUN dpkg --add-architecture i386
RUN apt-get -yqq update && apt-get upgrade -yqq && \
    apt-get install -yqq libasound2-dev && \
    apt-get install -yqq apt-utils pulseaudio libpulse-dev build-essential libpulse0 libpulse0:i386 dbus libssl-dev pkg-config libdbus-1-3 libdbus-1-dev
RUN ldconfig

RUN git clone --depth=1 --branch=master https://github.com/Spotifyd/spotifyd.git .

RUN cargo build --release --features pulseaudio_backend

FROM debian:stretch-slim as release

RUN apt-get update && \
    apt-get install -yqq --no-install-recommends libasound2 pulseaudio && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r spotify && \
    useradd --no-log-init -r -g spotify -G audio spotify

COPY --chown=spotify pulseaudio.client.conf /home/spotify/.config/pulse/client.conf

COPY --from=build /usr/src/spotifyd/target/release/spotifyd /usr/bin/

USER spotify

COPY entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
