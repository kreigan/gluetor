# Description

A base Docker Compose configuration for Gluetun + qBittorrent with ProtonVPN Wireguard
setup and port forwarding enabled.

- Port forwarding requires a ProtonVPN Plus subscription
- qBittorrent must be configured to allow passwordless localhost connections to WebUI
for port forwarding to work. For new installations, put a default config file in
`$QBT_CONFIG/qBittorrent/qBittorrent.conf` with the following contents:

  ```ini
  [Preferences]
  WebUI\LocalHostAuth=false
  ```

- `/dev/net/tun` is required on the host for Wireguard to work

## Services

|Service|Image|Description|
|-|-|-|
|`gluetun`|[`ghcr.io/kreigan/gluetor`](https://github.com/kreigan/gluetor/pkgs/container/gluetor)|`qmcgaw/gluetun` with the port-forwarding hook scripts baked in.|
|`qbt`|`linuxserver/qbittorrent`|A qBittorrent client container.|

## Environment Variables

Put the following variables in the respective environment files.

|Variable|Required|Default|Description|
|-|-|-|-|
|`WIREGUARD_PRIVATE_KEY`|+||Your Wireguard private key.|
|`WIREGUARD_ENDPOINT_IP`|+||ProtonVPN server IP.|
|`WIREGUARD_PUBLIC_KEY`|+||ProtonVPN server public key.|
|`WIREGUARD_ADDRESSES`|+||ProtonVPN assigned Wireguard address.|
|`QBT_CONFIG`|+||The path to the qBittorrent configuration directory on the host.|
|`QBT_DOWNLOADS`|+||The path to the qBittorrent downloads directory on the host.|
|`GLUETOR_VERSION`||`latest`|The image to use.|
|`PUID`||`1000`|The user ID for qBittorrent to run as inside the container.|
|`PGID`||`1000`|The group ID for qBittorrent to run as inside the container.|
|`WEBUI_PORT`||`8080`|The port to expose the qBittorrent WebUI on.|
|`TORRENTING_PORT`||`6881`|The port to expose for torrenting.|
|`TZ`||`Other/UTC`|The timezone to use in the containers.|
