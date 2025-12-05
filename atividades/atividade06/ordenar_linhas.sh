#!/bin/bash

for arquivo in "$1"/*; 
do
    if [ -f "$arquivo" ]; then
        linhas=$(wc -l < "$arquivo")
        echo "$linhas $arquivo"
    fi
done | sort -n
