#!/bin/bash

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
