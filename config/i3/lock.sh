#!/bin/bash

set -e
xset s off dpms 0 10 0
IMAGE=~/Pictures/lock.png
BRAIN_IMAGE="~/Pictures/Wallpapers/2018.01.08. brain os metallic wallpaper retina [2880x1800px].jpg"
if [[ -f "$BRAIN_IMAGE" ]]; then
    IMAGE="$BRAIN_IMAGE"
fi
#set $Locker "i3lock -i $([[ -e /home/nigel/Pictures/Backgrounds/Cortex-Wallpaper-Logo-desktop.png ]] && { echo \\"/home/nigel/Pictures/Backgrounds/Cortex-Wallpaper-Logo-desktop.png\\" ; } || \\{ echo \\"/home/nigel/Pictures/Backgorunds/Cortex-Wallpaper-Logo.png\\"; \\};) && sleep 1"
#set $Locker i3lock -i /home/nigel/Pictures/Backgrounds/Cortex-Wallpaper-Logo-lock.png && sleep 1
# i3lock --ignore-empty-password --image $IMAGE && sleep 1
~/.i3/i3lock-fancy-multimonitor/lock --no-text -b=0x8 && sleep 1
xset s off -dpms

