#!/usr/bin/env bash

mkdir -p ~/.cache

while true; do
  status=$(playerctl status 2>/dev/null)

  case "$status" in
    Playing)
      artist=$(playerctl metadata artist 2>/dev/null)
      title=$(playerctl metadata title 2>/dev/null)
      echo " $artist – $title" > ~/.cache/spotify.txt
      ;;
    Paused)
      echo "⏸ Paused" > ~/.cache/spotify.txt
      ;;
    Stopped|"")
      echo "⏹ Not playing" > ~/.cache/spotify.txt
      ;;
  esac

  sleep 2 
done
