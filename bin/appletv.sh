#!/usr/bin/env bash

for file in {,**/}*.{avi,mkv}; do
  convert-appletv.sh $file
done
