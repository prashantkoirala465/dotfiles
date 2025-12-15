#!/bin/bash

sketchybar --add event aerospace_workspace_change

sketchybar --add item workspace right \
            --set workspace script="$PLUGIN_DIR/aerospace_workspace.sh" \
            label.font="SF Pro:Semibold:16.0" \
            label.padding_left=8 \
            label.padding_right=12 \
            icon.drawing=off \
            background.drawing=off \
            update_freq=3 \
            --subscribe workspace aerospace_workspace_change
