#!/bin/sh

file="$HOME/Pictures/Screenshots/$(date +%Y%m%d-%H:%M:%S).png"

import "$file" &&
xclip -selection clipboard -t image/png -i "$file" &&
notify-send "Screenshot saved and copied to clipboard"
