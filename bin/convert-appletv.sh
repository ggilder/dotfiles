#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "No file arguments provided!"
  return 1
fi

while [ "$1" != "" ]; do
  out=`basename "$1" | sed s/.${1##*.}/.m4v/`
  HandBrakeCLI -i "$1" -o "$HOME/Desktop/$out" --preset "AppleTV 2"
  shift
done