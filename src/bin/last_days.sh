#!/bin/bash

# last_days - designed to create a smattering of files
# with mtimes for a set of days
#
# useful for testing backup / log rotation

function debug_last_days {
cat <<debug_last_days
	last_days_output_path=$last_days_output_path
	last_days_count=$last_days_count
	last_days_whence=$last_days_whence
	last_days_interval=$last_days_interval
	last_days_increment=$last_days_increment
debug_last_days
}

last_days_debug=${last_days_debug:-0}

last_days_output_path=${last_days_output_path:-$1}
last_days_output_path=${last_days_output_path:-.}
shift

mkdir -p "$last_days_output_path"

last_days_count=${last_days_count:-$1}
last_days_count=${last_days_count:-10}
shift

last_days_whence=${last_days_whence:-$1}
last_days_whence=${last_days_whence:-now}
shift

last_days_interval=${last_days_interval:-$1}
last_days_interval=${last_days_interval:-day}
shift

last_days_increment=${last_days_increment:-$1}
last_days_increment=${last_days_increment:-1}
shift

last_days_start=${last_days_start:-$1}
last_days_start=${last_days_start:-0}

last_days_date_format="%Y-%m-%d-%H-%M-%S"
last_days_dd_bs=${last_days_dd_bs:-1}
last_days_dd_if=${last_days_dd_if:-/dev/zero}
last_days_dd_count=${last_days_dd_count:-1}

last_days_file_label="generic"
last_days_file_extension="txt"

[[ "$last_days_debug" == 1 ]] && debug_last_days

function make_file_name
{
	echo "$last_days_output_path/$1-$last_days_file_label.$last_days_file_extension"
}

function generate_epoch_seconds
{
	local count
	for count in $( seq "$last_days_start" "$last_days_increment" "$last_days_count" )
	do
		# echo $count
		date -d "$last_days_whence - $count $last_days_interval" "+%s"
	done
}

function generate_file_date
{
	date -d "@$1" +"$last_days_date_format" 
}

for date in $( generate_epoch_seconds )
do
	file_date=$( generate_file_date "$date")
	file_name=$( make_file_name "$file_date")

	# echo "$file_name"
	dd status=none \
		bs="$last_days_dd_bs" \
		count="$last_days_dd_count" \
		if="$last_days_dd_if" \
		of="$file_name"

	touch --date "@$date" "$file_name"	
done
