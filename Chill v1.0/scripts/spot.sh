#!/bin/bash
# Commander-ShepardN7
# Extract metadata
ARTIST=$(playerctl --player=spotify metadata artist)
ALBUM=$(playerctl --player=spotify metadata album | fold -s -w 25)

# Get the current player status
STATUS=$(playerctl --player=spotify status 2>/dev/null)


# Fetch song position and duration
POSITION=$(playerctl --player=spotify position | awk '{printf "%d:%02d", $1/60, $1%60}')
DURATION=$(playerctl --player=spotify metadata mpris:length | awk '{printf "%d:%02d", $1/60000000, ($1/1000000)%60}')

# Calculate the progress percentage for the bar
POS_SECONDS=$(playerctl --player=spotify position | awk '{printf "%d", $1}')
DUR_SECONDS=$(playerctl --player=spotify metadata mpris:length | awk '{printf "%d", $1/1000000}')


# Display song information based on player status
if [ "$STATUS" == "Playing" ] || [ "$STATUS" == "Paused" ]; then
    if (( ${#ARTIST} > 32 )); then
        echo "by ${ARTIST:0:32}..."
    else
        echo "by $ARTIST"
    fi
else
    echo ""
fi


