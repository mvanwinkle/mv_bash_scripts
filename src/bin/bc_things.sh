#!/bin/bash

# I needed a way to round things; bc does that
# I believe I worked on other bash math stuff somewhere else
# but left this as an example for doing things with bc

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

