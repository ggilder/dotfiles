#!/usr/bin/env bash

set -e

if [ ! -d "$1" ]; then
	echo "$1 is not a directory!"
	exit
fi
if [ ! -d "$2" ]; then
	echo "$2 is not a directory!"
	exit
fi

HASHLOG=$(mktemp -t compare_dirs)

trap 'rm -f $HASHLOG' EXIT

cd "$1" && hashdeep -erl . > $HASHLOG
cd "$2" && hashdeep -erla -vv -k $HASHLOG .

exit