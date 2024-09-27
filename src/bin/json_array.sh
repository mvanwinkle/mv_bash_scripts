#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

test_data_dir="${SCRIPT_DIR}/../../tests/data/json_array"

json_array_string=$( cat "${test_data_dir}/array.json")
json_associative_array_string=$( cat "${test_data_dir}/associative_array.json" )


function create_array_from_json_string
{
	local -n arr="$1" ; shift
	local json_string="$1" ; shift

	local entry
	local value

	for entry in $( printf "%s" "$json_string" | jq -c '.[]' )
	do
		value="$(printf "%s" "$entry" | jq --raw-output '.+"x"' )"
		value=${value%x}
		arr+=( "$value" )
	done	
}

function test_array
{
	local the_array
	create_array_from_json_string the_array "$json_array_string"
	declare -p the_array
}

function create_associative_array_from_json_string
{
	local -n aarr="$1" ; shift
	local json_string="$1" ; shift

	local key

	local count=0

	local entry
	for entry in $( printf "%s" "$json_string" | jq 'to_entries[] | .key, .value' )
	do

		if [[ $((count%2)) == 0 ]]
		then
			key="$( printf "%s" "$entry" | jq --raw-output '.+"x"' )"
			key=${key%x}
		else
			value="$( printf "%s" "$entry" | jq --raw-output '.+"x"' )"
			value=${value%x}
			aarr["$key"]="$value"
		fi
		count=$((count+1))

	done


}

function test_associative_array
{
	local the_associative_array
	declare -A the_associative_array

	create_associative_array_from_json_string the_associative_array "$json_associative_array_string"

	declare -p the_associative_array
}

printf "JSON array string: \n%s\n" "$json_array_string"
test_array

printf "\n"

printf "JSON associative array string: \n%s\n" "$json_associative_array_string"
test_associative_array
