#!/bin/sh

WALLPAPERS_DIR=$HOME/.local/share/wallpapers

swaybg -i $(find $WALLPAPERS_DIR/. -type f | shuf -n1) -m fill &
OLD_PID=$!

while true; do
    sleep $((RANDOM % 301 + 300))

    RANDOM_IMAGE=$(find $WALLPAPERS_DIR/. -type f | shuf -n1)

    swaybg -i "$RANDOM_IMAGE" -m fill &
    NEXT_PID=$!

    sleep 5

    kill $OLD_PID
    OLD_PID=$NEXT_PID
done

