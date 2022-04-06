#!/bin/bash

# Line count of a string
function line_count
{
	printf "%s\n" "$1" | wc -l
}

# Shows the http headers of a request
function curl_get_http_headers
{
	local dl_uri="$1"; shift

	curl --no-styled-output --silent --head "${dl_uri}" 2>&1 
}

# Gets the filename of a remote http/https file
function get_filename_of_remote_file
{
	curl_get_http_headers "$1" \
	| grep ^content-disposition \
	| sed -E 's/.*"(.*)"$/\1/'
}

# Converts an IPv4 address / cidr to something
# that's appropriate for a filename
function convert_v4_cidr_to_file_name
{
	local cidr
	cidr="$1"; shift

	printf "%s" "$cidr" \
	| sed -e 's/\./_/g' -e 's/\//-/g'
}

