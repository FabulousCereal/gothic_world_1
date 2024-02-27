#!/bin/sh
WIDTH=640
for img in "$@"
do
	ffmpeg -width "$WIDTH" -i "$img" "${img%.svg}".png
done
