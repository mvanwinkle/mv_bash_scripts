#!/bin/bash


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
	echo "Final file name: $final_filename"
}

# output_file="${filename}__${ratio}.${wanted_extension}"
output_file=$( mktemp /tmp/XXXXXXX.mp4 )
rm -f "$output_file"

debug

#bn=$(basename -- "$input_file")
extension="${input_file##*.}"

if [[ "$extension" == "mp4" ]]
then
	echo "File is already mp4."
	exit
fi
filename="${input_file%.*}"

final_filename="$filename.mp4"

if [[ -e "$final_filename" ]]
then
	echo "File $final_filename already exists."
	exit
fi


ffmpeg -i "$input_file" -vf scale=${ratio}:-1 "$output_file"
result="$?"

if [[ "$result" == "0" ]]
then
	rm "$input_file"
	mv "$output_file" "$final_filename"
	ln -s "$final_filename" "$input_file"
fi

date
