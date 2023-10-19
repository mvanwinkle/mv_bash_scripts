#!/bin/bash

# This is NOT the best way (now, at least) to
# view DICOM files on Linux.
#
# The best way I've found is to use wine to run
# the executables that come with the data disks
# your provided.

where="$1"; shift
if [[ -z "$where" ]]
then
	>&2 echo "Path is first argument."
	exit 1;
fi
if [[ ! -e "$where" ]]
then
	>&2 echo "$where does not exist."
	exit 1;
fi

find "$where" -type f \
| sort \
| xargs \
  display -equalize -resize 1800x1000
