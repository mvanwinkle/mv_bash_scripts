#!/bin/bash

# This is based off of the post here:
# https://superuser.com/questions/178025/linux-copy-to-fat32-filesystem-invalid-argument

# The response contains test code for what might not work on a fat file system:
#!/bin/sh
#touch questionmark?
#touch less<
#touch less\<
#touch more\>
#touch backslash\\
#touch colon:
#touch asterisk\*
#touch pipe\|
#touch inch\"
#touch carret\^
#touch comma,
#touch semicolon\;
#touch plus+
#touch equals=
#touch lbracket[
#touch rbracket]
#touch quote\'

# pax -rw -s '/[?<>\\:*|\"]/_/gp' source dest

pax -rw -s '/[?<>\\:*|\"]/_/gp' "$@"
