#!/bin/bash

sketchybar --add item calendar center \
           --set calendar icon.drawing=off \
                          background.drawing=off \
                          update_freq=30 \
                          script="$PLUGIN_DIR/calendar.sh"
