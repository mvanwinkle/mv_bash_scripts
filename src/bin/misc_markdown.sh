#!/bin/bash

# Outputs a comment in markdown; I believe I was using this
# as part of automatically generating markdown and just
# didn't delete it.

function markdown_comment
{
	local comment="$1"; shift
	printf '\n[//]: # (Generated: %s)\n' "$comment"
}

