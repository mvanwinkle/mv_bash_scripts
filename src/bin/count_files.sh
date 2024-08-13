#!/bin/bash

# For a given directory it counts the number of files under
# the subdirectories

dir="$1" ; shift 

if [[ -z "$dir" ]]
then
	dir='.'
fi

find "$dir" -maxdepth 1 -mindepth 1 -type d | \
while read d
do
	wc=$( find "$d" -type f | wc -l )
	printf "$d\t$wc\n"
done

