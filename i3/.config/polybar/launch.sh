#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar >/dev/null

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar 2>/dev/null; do sleep 1; done

# Launch polybar
polybar simple &
polybar down & 

notify-send -u low "Polybar launched..."
