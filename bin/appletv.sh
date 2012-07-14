#!/usr/bin/env zsh

files=(**/*.(avi|mkv|mov))
for file in $files; do
  convert-appletv.sh "$file"
done
