#!/bin/bash

case "$BLOCK_BUTTON" in
1)
    chosen=$(
        printf "shutdown\nrestart\nhibernate" | dmenu
    )

    case $chosen in
    "shutdown")
        notify-send "Shutting Down in 5s"
        sleep 5 && systemctl poweroff
        ;;
    "restart")
        notify-send "Restarting in 5s"
        systemctl reboot
        ;;
    "hibernate")
        systemctl hibernate
        ;;
    *)
        notify-send "Invalid Choice"
        exit 1
        ;;
    esac

    exit 0
    ;;
esac

if ! acpi -V | grep -q "Adapter 0: on-line"; then
    echo "<span foreground='#FF0000' background='#1e1e3e'> ⏻ </span>"
fi

echo "<span foreground='#cba8f7' background='#1e1e3e'> ⏻ </span>"
