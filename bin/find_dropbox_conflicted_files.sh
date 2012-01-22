#!/usr/bin/env bash

find ~/Dropbox -name "*conflicted copy*" -not -path "$HOME/Dropbox/.dropbox.cache/*"
