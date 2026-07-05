#!/usr/bin/env bash

mkdir -p ~/.cache

last=""

while true; do
  artist=$(playerctl -p spotify metadata artist 2>/dev/null)
  title=$(playerctl -p spotify metadata title 2>/dev/null)

  if [ -z "$artist" ] && [ -z "$title" ]; then
    current="⏹ not playing"
  else
    current=" $artist – $title"
  fi

  if [ "$current" != "$last" ]; then
    echo "$current" > ~/.cache/spotify.txt
    last="$current"
  fi

  sleep 1
done
