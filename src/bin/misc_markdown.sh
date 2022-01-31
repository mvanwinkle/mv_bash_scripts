#!/bin/bash

function markdown_comment
{
	local comment="$1"; shift
	printf '\n[//]: # (Generated: %s)\n' "$comment"
}

