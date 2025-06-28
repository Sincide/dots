#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
wallpaper=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
swww img "$wallpaper" --transition-type any
