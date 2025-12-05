#!/bin/bash

valores=$(cut -d',' -f2 compras.txt | grep -E '[0-9]')

total=$(echo "$valores" | tr -d ' ' | paste -sd'+' - | bc)

echo "Valor total das compras: $total"
