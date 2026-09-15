#!/usr/bin/env sh

# https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/vpn-port-forwarding.md#qbittorrent-example
WEBUI_URL="http://127.0.0.1:${WEBUI_PORT:-8080}"

wget -O- \
    --timeout=10 \
    --tries=5 \
    --retry-connrefused \
    --header "Referer: ${WEBUI_URL}" \
    --header "Origin: ${WEBUI_URL}" \
    --post-data 'json={ \
      "listen_port":0, \
      "current_network_interface":"lo" \
    }' \
    "${WEBUI_URL}/api/v2/app/setPreferences" 2>&1
