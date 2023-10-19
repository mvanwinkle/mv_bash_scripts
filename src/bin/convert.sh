#!/bin/bash

# Another poorly written wrapper to ffmpeg

input_file="$1"; shift
ratio=640
wanted_extension="mp4"

bn_input_file=$( basename -- "$input_file")

extension="${bn_input_file##*.}"
filename="${bn_input_file%.*}"
function debug {
	date
	echo File "$bn_input_file"
	echo Extension "$extension"
	echo filename "$filename"
	echo "Output file" $output_file
}

output_file="${filename}__${ratio}.${wanted_extension}"
debug

if [[ -e "$output_file" ]]
then
	>&2 echo "Error: $output_file already exists..."
	exit
fi

ffmpeg -i "$input_file" -vf scale=${ratio}:-1 "$output_file"
date
