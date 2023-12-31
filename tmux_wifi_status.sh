#!/bin/bash

SIGNAL=$(iw dev wlan0 link | grep 'signal:' | awk '{print $2}')

# note: replaced graph with unavailable glyph for now

if [[ $SIGNAL -lt -90 ]]; then
    #BAR_STR="[▂___]"
    BAR_STR="[▆   ]"
elif [[ $SIGNAL -lt -67 ]]; then
    #BAR_STR="[▂▄__]"
    BAR_STR="[▆▆  ]"
elif [[ $SIGNAL -lt -55 ]]; then
    #BAR_STR="[▂▄▆_]"
    BAR_STR="[▆▆▆ ]"
elif [[ $SIGNAL -lt -30 ]]; then
    #BAR_STR="[▂▄▆█]"
    BAR_STR="[▆▆▆▆]"
elif [[ $SIGNAL -lt -1 ]]; then
    #BAR_STR="[▂▄▆█]"
    BAR_STR="[▆▆▆▆]"
else
    BAR_STR="[_XX_]"
fi

echo -n "${BAR_STR}"
#echo -n "${SIGNAL}${BAR_STR}"
