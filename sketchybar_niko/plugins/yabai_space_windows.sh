#!/bin/bash

# prevapps=$(aerospace list-windows --workspace "$PREV_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
prevapps=$(yabai -m query --windows --space $PREV_WORKSPACE | jq  '.[].app')
if [ "${prevapps}" != "" ]; then
  sketchybar --set space.$PREV_WORKSPACE drawing=on
  icons_prev=" "
  for app in $prevapps; do
    icons_prev="$icons_prev $(~/.config/sketchybar/icon_map.sh "$app")"
  done
  sketchybar --set space.$PREV_WORKSPACE label="$icons_prev"
else
  sketchybar --set space.$PREV_WORKSPACE drawing=off
fi

# apps=$(aerospace list-windows --workspace "$FOCUSED_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
apps=$(yabai -m query --windows --space "$FOCUSED_WORKSPACE" | jq  '.[].app')
sketchybar --set space.$FOCUSED_WORKSPACE drawing=on
icons_focus=" "
if [ "${apps}" != "" ]; then
  for app in $apps; do
    icons_focus="$icons_focus $(~/.config/sketchybar/icon_map.sh "$app")"
  done
else
  icons_focus=""
fi
sketchybar --set space.$FOCUSED_WORKSPACE label="$icons_focus"
