#!/usr/bin/env bash

# Module signal number for manual refresh
MODULE_SIGNAL=5  # make sure this matches your waybar config

LOCAL_IP="192.168.1.251"
NETBIRD_IP="10.20.30.10"

# Ping each IP once with 1s timeout
ping -c 1 -W 1 "$LOCAL_IP" &>/dev/null
LOCAL_STATUS=$?
ping -c 1 -W 1 "$NETBIRD_IP" &>/dev/null
VPN_STATUS=$?

# Tooltip lines
if [ $LOCAL_STATUS -eq 0 ]; then
    tooltip="󰒋 Local - reachable\n"
else
    tooltip="󰒏 Local - unreachable\n"
fi

if [ $VPN_STATUS -eq 0 ]; then
    tooltip+="󰱓 VPN - reachable"
else
    tooltip+="󰅛 VPN - unreachable"
fi

# Determine overall icon
if [ $LOCAL_STATUS -eq 0 ] && [ $VPN_STATUS -eq 0 ]; then
    icon="󰒋"  # both up
elif [ $LOCAL_STATUS -eq 0 ] || [ $VPN_STATUS -eq 0 ]; then
    icon=""  # one up
else
    icon="󰒏"  # both down
fi

# Output JSON for Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\", \"class\": \"server-status\"}"
