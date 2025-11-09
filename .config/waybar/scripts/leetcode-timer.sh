#!/bin/bash

# LeetCode Timer Script
# Stores timer state in /tmp/leetcode_timer

STATE_FILE="/tmp/leetcode_timer"
LOCK_FILE="/tmp/leetcode_timer.lock"

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "0|stopped" > "$STATE_FILE"
fi

# Function to read current state
read_state() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "0|stopped"
    fi
}

# Function to write state with lock
write_state() {
    exec 200>"$LOCK_FILE"
    flock -x 200
    echo "$1" > "$STATE_FILE"
    exec 200>&-
}

# Function to format time
format_time() {
    local total_seconds=$1
    local hours=$((total_seconds / 3600))
    local minutes=$(((total_seconds % 3600) / 60))
    local seconds=$((total_seconds % 60))
    
    if [ $hours -gt 0 ]; then
        printf "%02d:%02d:%02d" $hours $minutes $seconds
    else
        printf "%02d:%02d" $minutes $seconds
    fi
}

# Handle commands
case "$1" in
    start)
        current_state=$(read_state)
        IFS='|' read -r elapsed status <<< "$current_state"
        
        if [ "$status" != "running" ]; then
            start_time=$(($(date +%s) - elapsed))
            write_state "$elapsed|running|$start_time"
        fi
        ;;
        
    stop)
        current_state=$(read_state)
        IFS='|' read -r elapsed status start_time <<< "$current_state"
        
        if [ "$status" = "running" ]; then
            current_time=$(date +%s)
            new_elapsed=$((current_time - start_time))
            write_state "$new_elapsed|stopped"
        fi
        ;;
        
    reset)
        write_state "0|stopped"
        ;;
        
    toggle)
        current_state=$(read_state)
        IFS='|' read -r elapsed status start_time <<< "$current_state"
        
        if [ "$status" = "running" ]; then
            # Stop the timer
            current_time=$(date +%s)
            new_elapsed=$((current_time - start_time))
            write_state "$new_elapsed|stopped"
        else
            # Start the timer
            start_time=$(($(date +%s) - elapsed))
            write_state "$elapsed|running|$start_time"
        fi
        ;;
        
    *)
        # Display current time
        current_state=$(read_state)
        IFS='|' read -r elapsed status start_time <<< "$current_state"
        
        if [ "$status" = "running" ]; then
            current_time=$(date +%s)
            elapsed=$((current_time - start_time))
        fi
        
        formatted_time=$(format_time $elapsed)
        
        # Choose icon based on status
        if [ "$status" = "running" ]; then
            icon="󰏤"  # Pause icon (running)
            class="running"
        else
            icon="󰐊"  # Play icon (stopped)
            class="stopped"
        fi
        
        # Output JSON for Waybar
        echo "{\"text\":\"$icon $formatted_time\",\"class\":\"$class\",\"tooltip\":\"LeetCode Timer\\nClick: Start/Stop\\nRight-click: Reset\"}"
        ;;
esac
