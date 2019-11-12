#!/bin/bash

if [ "$1" = "-ltew" -a "$2" = "1000" ]; then
shift 2
/bin/ls.coreutils -ltw 1000 --time-style=+'%a %b %d %H:%M:%S %Y' $@
else
/bin/ls.coreutils $@
fi
