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

function create_associative_array_from_json_string
{
	local -n aarr="$1" ; shift
	local json_string="$1" ; shift

	local key

	local count=0
	for entry in $( printf "%s" "$json_string" | jq 'to_entries[] | .key, .value' )
	do
		if [[ $((count%2)) == 0 ]]
		then
			key=$( printf "%s" "$entry" | jq --raw-output )
		else
			aarr["$key"]=$( printf "%s" "$entry" | jq --raw-output )
		fi
		count=$((count+1))
	done


}

function test_associative_array
{
	local the_associative_array
	declare -A the_associative_array
	create_associative_array_from_json_string the_associative_array '{ "a":"1","b":"2"}'

	declare -p the_associative_array
}

# test_array

test_associative_array
