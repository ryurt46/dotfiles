#!/bin/bash

# Get the current windows on Monitor 1 using i3's tree structure
i3-msg -t get_tree | jq '.. | select(.type=="con" and .window_properties.class) | .name' | awk NF
