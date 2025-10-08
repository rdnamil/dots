#!/bin/bash

# lockscreen.sh
# ---
# Created:      Jun 24, 2025
# Modified:     Jun 24, 2025
# Author:       rdnamil
# Description:  Change lockscreen background to match current swww wallpaper
# ---

# get the current wallpaper's path and copy to temp file
currentWall=$(sed -e 's#.*image:\(\)#\1#' <<< $(swww query | head -n 1))
cp $currentWall /home/andrel/Pictures/Wallpapers/.current_wall

# check if hyprlock is already running
if pgrep -x "hyprlock" > /dev/null; then	# don't run hyprlock if already running
    break
else
    hyprlock --grace 5	# start hyprlock
fi
