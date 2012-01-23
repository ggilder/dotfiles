#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "No file arguments provided!"
  return 1
fi

for file in $@; do
  test -f "$file" || continue
  out=`basename "$file" | sed s/.${file##*.}/.m4v/`
  HandBrakeCLI -i "$file" -o "$HOME/Desktop/$out" --preset "AppleTV 2"
done
