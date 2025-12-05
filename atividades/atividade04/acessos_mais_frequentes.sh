#!/bin/bash
cut -d',' -f1 acessos.log | tr -d ' ' | sort | uniq -c | head -n1 |sort -r |tr -s ' ' |cut -d' ' -f3

