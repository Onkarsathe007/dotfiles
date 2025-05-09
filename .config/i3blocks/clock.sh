#!/bin/bash

# Show calendar on middle-click, with position shift
case "$BLOCK_BUTTON" in
2) gsimplecal --x=-100 --y=30 & ;;
esac

# Print the clock
echo "<span foreground='#cba8f7' background='#1e1e3e'>  $(date '+%I:%M %p')</span>"
