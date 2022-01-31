#!/bin/bash

function get_list_of_padded_numbers
{
	local from="$1"; shift
	local to="$1"; shift
	local padding="$1"; shift

	for i in $( seq "$from" "$to" )
	do
		printf "%*s%s\n" "$padding" "$i"
	done
}
function line_count
{
	printf "%s\n" "$1" | wc -l
}

function find_list_number_padding
{
	local content="$1";

	local count=$( line_count "$content" )

	local bc_code="l($count)/l(10)"
	local float=$( run_bc_code "$bc_code" )
	local rounded=$(cheap_round "$float" )
	printf "%s" "$rounded"
}
