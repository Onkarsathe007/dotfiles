#!/bin/bash

# Show calendar on middle-click
case "$BLOCK_BUTTON" in
2) gsimplecal --x=-100 --y=30 & ;;
esac

# Get time with seconds
TIME=$(date '+%I:%M:%S %p')     # 12-hour format with seconds
TOOLTIP=$(date '+%A, %d %B %Y') # e.g. Wednesday, 18 June 2025

# Output for i3blocks
echo "<span foreground='#cba8f7' background='#1e1e3e'>  $TIME</span>"
echo "$TOOLTIP"
echo "#1e1e3e"
