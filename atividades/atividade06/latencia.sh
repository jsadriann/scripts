#!/bin/bash

ARQ=$1

while read ip; do
    echo "Pingando $ip"
    media=$(ping -c 3 -q $ip | grep "rtt" | cut -d'/' -f5)
    if [ -z "$media" ]; then
        media=999999
    fi
    echo "$media $ip"
done < $ARQ | sort -n

