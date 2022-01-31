#!/bin/bash

function cheap_round
{
	local num="$1"; shift

	local bc_code="$num+.5"
	run_bc_code "$bc_code" \
	| bc -l \
	| awk -F'.' '{print $1}'
}

function run_bc_code
{
	local bc_code="$1"; shift

	printf "%s\n" "$bc_code" | bc -l
}

