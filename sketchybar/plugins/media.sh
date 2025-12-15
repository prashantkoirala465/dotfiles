#!/bin/bash

# Try Spotify via AppleScript first (most reliable)
if pgrep -x "Spotify" > /dev/null; then
  SPOTIFY_DATA=$(osascript -e 'tell application "Spotify"
    if player state is playing then
      return name of current track & "|" & artist of current track
    else
      return "paused"
    end if
  end tell' 2>/dev/null)
  
  if [ "$SPOTIFY_DATA" != "paused" ] && [ -n "$SPOTIFY_DATA" ]; then
    TITLE=$(echo "$SPOTIFY_DATA" | cut -d'|' -f1)
    ARTIST=$(echo "$SPOTIFY_DATA" | cut -d'|' -f2)
    MEDIA="$TITLE - $ARTIST"
    sketchybar --set $NAME label="$MEDIA" drawing=on
    exit 0
  fi
fi

# Try Music app via AppleScript
if pgrep -x "Music" > /dev/null; then
  MUSIC_DATA=$(osascript -e 'tell application "Music"
    if player state is playing then
      return name of current track & "|" & artist of current track
    else
      return "paused"
    end if
  end tell' 2>/dev/null)
  
  if [ "$MUSIC_DATA" != "paused" ] && [ -n "$MUSIC_DATA" ]; then
    TITLE=$(echo "$MUSIC_DATA" | cut -d'|' -f1)
    ARTIST=$(echo "$MUSIC_DATA" | cut -d'|' -f2)
    MEDIA="$TITLE - $ARTIST"
    sketchybar --set $NAME label="$MEDIA" drawing=on
    exit 0
  fi
fi

# Try nowplaying-cli as fallback
if command -v nowplaying-cli &> /dev/null; then
  TITLE=$(nowplaying-cli get title 2>/dev/null)
  ARTIST=$(nowplaying-cli get artist 2>/dev/null)
  STATE=$(nowplaying-cli get playbackRate 2>/dev/null)
  
  if [ -n "$TITLE" ] && [ "$TITLE" != "null" ]; then
    if [ "$STATE" = "1" ] || [ "$STATE" = "1.000000" ] || [ "$STATE" = "1.0" ]; then
      if [ -n "$ARTIST" ] && [ "$ARTIST" != "null" ]; then
        MEDIA="$TITLE - $ARTIST"
      else
        MEDIA="$TITLE"
      fi
      sketchybar --set $NAME label="$MEDIA" drawing=on
      exit 0
    fi
  fi
fi

# Try event-based approach (media_change subscription)
if [ -n "$INFO" ]; then
  STATE="$(echo "$INFO" | jq -r '.state' 2>/dev/null)"
  if [ "$STATE" = "playing" ]; then
    MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist' 2>/dev/null)"
    if [ -n "$MEDIA" ] && [ "$MEDIA" != "null - null" ]; then
      sketchybar --set $NAME label="$MEDIA" drawing=on
      exit 0
    fi
  fi
fi

# Nothing is playing, hide the widget
sketchybar --set $NAME drawing=off
