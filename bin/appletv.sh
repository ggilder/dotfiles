#!/usr/bin/env zsh

for file in {,**/}*.{avi,mkv,mov}; do
  convert-appletv.sh "$file"
done
