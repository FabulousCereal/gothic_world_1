#!/bin/sh
# SPDX-FileCopyrightText: 2024 Grupo Warominutes
# SPDX-License-Identifier: Apache-2.0

print_ico_args() {
	name=\'"$1"\'
	sizes="16 32 64 128 256"
	for size in $sizes; do
		echo -width $size -i "$name"
	done

	i=0
	for size in $sizes; do
		if [ $size -ge 256 ]; then
			fmt=rgba
			codec=png
		else
			fmt=pal8
			codec=bmp
		fi
		echo -map $i -pix_fmt:$i $fmt -c:$i $codec
		i=$((i + 1))
	done
	echo \'"$2"\'
}

add_ico() {
	print_ico_args "$in_ico" "$out_ico" | xargs ffmpeg -y -hide_banner
	wine "$res_hacker" -open "$love_exe" -save "$game_exe" \
		-action addoverwrite -res "$out_ico" \
		-mask ICONGROUP,MAINICON,
	rm "$love_exe" "$out_ico"
}

if [ -n "$3" ]; then
	src_dir="$1"
	public_name=$(realpath "$2")
	love_zip="$3"

	if [ -e "$public_name" ]; then
		echo Dir \""$public_name"\" already exists. Please move it out
		echo of the way to avoid losing data.
		exit 1
	fi
	if ! 7za e -o"$public_name" "$love_zip" '*.dll' love.exe license.txt -r; then
		rm -r "$public_name"
		echo Failed to extract \""$love_zip"\"
		exit 1
	fi

	love_exe="$public_name"/love.exe
	game_exe="$public_name"/"${public_name##*/}".exe
	out_ico="$public_name"/.ico
	if [ -n "$5" ]; then
		res_hacker="$4"
		in_ico="$5"
		add_ico &
	else
		mv "$love_exe" "$game_exe"
	fi

	compress_well="-mx=9 -mfb=258 -mpass=15"
	out_love=$(realpath "$public_name".love)
	(
		cd "$src_dir"
		if ! 7za a -tzip $compress_well -- "$out_love" * ; then
			rm -r "$public_name"
			echo Failed to add files to archive
			exit 1
		fi
	)

	wait
	cat "$out_love" >> "$game_exe"
	rm "$out_love"
	final_pkg="$public_name".zip
	exec 7za a -sdel $compress_well -- "$final_pkg" "$public_name"
else
	echo Usage: "$0" src_dir public_name love_zip [path/to/resource_hacker.exe path/to/ico.svg]
	echo Requires: wine 7zip ffmpeg
	echo Requires: 'love-*.zip' ResourceHacker.exe
fi
