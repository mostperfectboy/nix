#!/usr/bin/env bash

get_lyrics() {
    if ! command -v sptlrx &> /dev/null; then
        echo "sptlrx not installed"
        return 1
    fi
    
    local output=$(timeout 1 sptlrx pipe --player mpris 2>&1)
    
    if [[ -n "$output" && "$output" != *"error"* && "$output" != *"failed"* ]]; then
        echo "$output"
    else
        local artist=$(playerctl -p spotify metadata artist 2>/dev/null)
        local title=$(playerctl -p spotify metadata title 2>/dev/null)
        if [[ -n "$artist" && -n "$title" ]]; then
            echo "$artist - $title"
        elif [[ -n "$title" ]]; then
            echo "$title"
        else
            echo ""
        fi
    fi
}

output_json() {
    local text="$1"
    local status=$(playerctl status 2>/dev/null || echo "Stopped")
    local class="lyrics"
    
    if [[ "$status" == "Playing" ]]; then
        class="lyrics-playing"
    elif [[ "$status" == "Paused" ]]; then
        class="lyrics-paused"
    fi
    
    if [[ -z "$text" ]]; then
        echo "{\"text\": \"\", \"class\": \"$class\", \"alt\": \"$status\"}"
    else
        echo "{\"text\": \"$text\", \"class\": \"$class\", \"alt\": \"$status\"}"
    fi
}

while true; do
    lyrics=$(get_lyrics)
    output_json "$lyrics"
    sleep 1
done
