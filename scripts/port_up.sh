#!/usr/bin/env sh

FORWARDED_PORT="$1"
VPN_INTERFACE="$2"
WEBUI_URL="http://127.0.0.1:${WEBUI_PORT:-8080}"

echo "new port $FORWARDED_PORT on interface $VPN_INTERFACE"

if [ -z "$FORWARDED_PORT" ] || [ -z "$VPN_INTERFACE" ]; then
    echo "Missing required arguments. Usage: port_up.sh <FORWARDED_PORT> <VPN_INTERFACE>"
    exit 1
fi

payload=$(cat <<EOF
{
  "listen_port": $FORWARDED_PORT,
  "current_network_interface": "$VPN_INTERFACE",
  "random_port": false,
  "upnp": false
}
EOF
)

echo "Updating qBittorrent settings: $payload"

wget -O- \
    --timeout=10 \
    --tries=5 \
    --retry-connrefused \
    --header "Referer: ${WEBUI_URL}" \
    --header "Origin: ${WEBUI_URL}" \
    --post-data "json=$payload" \
    "${WEBUI_URL}/api/v2/app/setPreferences" 2>&1
