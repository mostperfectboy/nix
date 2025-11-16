#!/usr/bin/env bash

# Function to get player status
get_player_status() {
    playerctl status 2>/dev/null || echo "No players found"
}

# Function to get metadata
get_metadata() {
    local artist=$(playerctl metadata artist 2>/dev/null)
    local title=$(playerctl metadata title 2>/dev/null)
    if [[ -n "$artist" && -n "$title" ]]; then
        echo "$artist - $title"
    elif [[ -n "$title" ]]; then
        echo "$title"
    else
        echo "No metadata available"
    fi
}

# Function to output JSON
output_json() {
    local text="$1"
    local player_name=$(playerctl -l | head -n1)
    echo "{\"text\": \"$text\", \"class\": \"custom-$player_name\", \"alt\": \"$player_name\"}"
}

# Main logic
while true; do
    status=$(get_player_status)
    if [[ "$status" == "Playing" ]]; then
        metadata=$(get_metadata)
        output_json " $metadata"
    elif [[ "$status" == "Paused" ]]; then
        metadata=$(get_metadata)
        output_json ""
    else
        output_json ""
    fi
    sleep 1
done