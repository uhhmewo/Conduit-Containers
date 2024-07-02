#!/bin/bash
# "THE BEER-WARE LICENSE" (Revision 42): Exponential-Workload wrote this file.  As long as you retain this notice you can do whatever you want with this stuff. If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.

set -e

export CONFIG_FILE="$CONFIG_FILE"
export INTERFACE_NAME="$INTERFACE_NAME"
export CONFIG_DIR="${CONFIG_DIR:-"/etc/wireguard-cfg.d"}"

start_wireguard() {
  echo "WG: Starting WireGuard interface: $INTERFACE_NAME"
  wg-quick up "$CONFIG_FILE"
}

if ([[ -d "$CONFIG_DIR" ]] && [ "$(ls -A $CONFIG_DIR)" ]) || [[ "$CONFIG_FILE" != "" ]]; then
  CONFIG_FILE="${CONFIG_FILE:-"$CONFIG_DIR/$(ls "$CONFIG_DIR" | shuf -n 1)"}"
  INTERFACE_NAME="${INTERFACE_NAME:-"$(basename "$CONFIG_FILE" .conf)"}"
  mkdir -p /tmp/wg-setup
  NEW_CONFIG_FILE="/tmp/wg-setup/$INTERFACE_NAME.conf"
  cp "$CONFIG_FILE" "$NEW_CONFIG_FILE"
  CONFIG_FILE="$NEW_CONFIG_FILE"
  chown root "$CONFIG_FILE"
  chmod 700 "$CONFIG_FILE"

  start_wireguard "$CONFIG_FILE"

  export IPV4_ADDRESS="$(ip -4 addr show dev "$INTERFACE_NAME" | awk '/inet/ {print $2}' | cut -d/ -f1)"
  export IPV6_ADDRESS="$(ip -6 addr show dev "$INTERFACE_NAME" | awk '/inet6/ {print $2}' | cut -d/ -f1)"
  echo "WG: Internal VPN IPv4: $IPV4_ADDRESS"
  echo "WG: Internal VPN IPv6: $IPV6_ADDRESS"
elif [[ "$FORCE_WG" != "" ]]; then
  echo "WG: No WireGuard configuration files found in $CONFIG_DIR" 1>&2
  exit 1
else
  echo "WG: Skipping, empty directory $CONFIG_DIR" 1>&2
fi

exec "$@"
