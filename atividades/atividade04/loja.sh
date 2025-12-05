#!/bin/bash

linha_maior=$(grep -v "Produto" compras.txt | sort -t',' -k2 -nr | head -n1)
loja=$(echo "$linha_maior" | cut -d',' -f3)
echo "Loja com produto mais caro: $loja"
