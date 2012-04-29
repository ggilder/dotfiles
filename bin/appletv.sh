#!/usr/bin/env bash

for file in {,**/}*.{avi,mkv,mov}; do
  convert-appletv.sh $file
done
