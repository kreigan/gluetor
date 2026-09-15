# syntax=docker/dockerfile:1
FROM qmcgaw/gluetun:v3.41.3@sha256:1baa76576dea1dfbafbd62bb635daf40fd87171f63273c2fdfe630418783011e

COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

LABEL autoheal=true

ENV VPN_SERVICE_PROVIDER=protonvpn
ENV VPN_TYPE=wireguard
ENV VPN_INTERFACE=wg0
ENV VPN_PORT_FORWARDING=on
ENV HTTPPROXY=off
ENV SHADOWSOCKS=off
ENV VPN_PORT_FORWARDING_UP_COMMAND="/bin/sh -c '/scripts/port_up.sh {{PORT}} {{VPN_INTERFACE}}'"
ENV VPN_PORT_FORWARDING_DOWN_COMMAND="/bin/sh -c /scripts/port_down.sh"
