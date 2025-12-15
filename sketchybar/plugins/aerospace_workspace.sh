#!/bin/bash

# Always query the focused workspace (reliable, no dependency on env var)
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

sketchybar --set $NAME label="$FOCUSED_WORKSPACE"
