#!/bin/bash
sketchybar --add event aerospace_workspace_change
sketchybar --add item workspace right \
            --set workspace script="$PLUGIN_DIR/aerospace_workspace.sh" \
            label.font="SF Pro:Semibold:16.0" \
            label.color=0xff000000 \
            label.padding_left=6 \
            label.padding_right=6 \
            icon.drawing=off \
            background.drawing=on \
            background.border_width=2 \
            background.border_color=0xffffffff \
            background.color=0xffffffff \
            background.corner_radius=2 \
            background.height=20 \
            background.padding_left=4 \
            background.padding_right=4 \
            update_freq=3 \
            --subscribe workspace aerospace_workspace_change
