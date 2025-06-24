#!/bin/sh

pidof -q gpu-screen-recorder && exit 0

video_path="$HOME/Videos/Replays/$1"
mkdir -p "$video_path"

gpu-screen-recorder -w screen -f 60 -a default_output -c mkv -bm cbr -q 75000 -cr full -r 30 -k hevc_hdr -o "$video_path" -v no
