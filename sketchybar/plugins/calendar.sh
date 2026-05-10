#!/bin/bash

sketchybar --set $NAME label="$(date +'%a %l:%M %p' | tr -s ' ')"
