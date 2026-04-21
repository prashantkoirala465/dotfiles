#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
  focused_workspace="$(aerospace list-workspaces --focused)"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  # Keep the left-side workspace number synced with Aerospace.
  sketchybar --set space.1 icon="$focused_workspace"
  sketchybar --set space.$space label="$icon_strip"
fi
