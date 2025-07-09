#!/bin/sh
# SPDX-FileCopyrightText: 2024 Grupo Warominutes
# SPDX-License-Identifier: Apache-2.0
WIDTH=640
for img in "$@"
do
	ffmpeg -width "$WIDTH" -i "$img" "${img%.svg}".png
done
