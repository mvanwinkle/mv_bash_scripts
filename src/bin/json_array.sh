#!/bin/bash

input_file='blah.json'

function create_array_from_json_string
{
	local -n arr="$1" ; shift
	local json_string="$1" ; shift

	# printf "Json string: %s\n" "$json_string"

	for entry in $( printf "%s" "$json_string" | jq -c '.[]' )
	do
		arr+=( $(printf "%s" "$entry" | jq --raw-output ) )
	done	
}

function test_array
{
	local the_array
	create_array_from_json_string the_array '[ "a","b","c"]'
	declare -p the_array
}

test_array
