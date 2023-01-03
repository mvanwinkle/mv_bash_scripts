#!/bin/bash

declare -A dy_dispatch_control

dy_dispatch_control["ASCII text","command"]="cat"
dy_dispatch_control["ASCII text","argc"]=1
dy_dispatch_control["ASCII text","argv",0]="%s"

dy_dispatch_control["gzip compressed data","command"]="zcat"
dy_dispatch_control["gzip compressed data","argc"]=1
dy_dispatch_control["gzip compressed data","argv",0]="%s"

all_arguments=( "$@" )

for file_name in "${all_arguments[@]}"
do
	# printf "%s\n" "$file_name"

	file_type=$( file -b "$file_name" | awk -F',' '{print $1}' )
	
	# printf "File type: %s\n" "$file_type"

	unset command_arguments
	declare -a command_arguments

	to=${dy_dispatch_control["$file_type","argc"]}
	i=0
	while [ $i -ne $to ]
	do
		index="$file_type","argv",$i
		argument=${dy_dispatch_control[$index]}
		append_me=$( printf "$argument" "$file_name" )
		command_arguments+=("$append_me")
		i=$(($i+1))
	done

	# printf "${command_arguments[@]}\n"

	# echo "Command: " "${dy_dispatch_control["$file_type","command"]}" "${command_arguments[@]}"
	"${dy_dispatch_control["$file_type","command"]}" "${command_arguments[@]}"
done
