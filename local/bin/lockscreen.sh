#!/bin/bash

# lockscreen.sh
# ---
# Created:      Jun 24, 2025
# Modified:     Jun 24, 2025
# Author:       rdnamil
# Description:  Change lockscreen background to match current swww wallpaper
# ---

currentWall=$(sed -e 's#.*image:\(\)#\1#' <<< $(swww query))

cp $currentWall /home/andrel/Pictures/Wallpapers/.current_wall

hyprlock
