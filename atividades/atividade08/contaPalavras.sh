#!/usr/bin/env bash

read -p "Informe o arquivo: " arquivo

if [ ! -f "$arquivo" ]; then
  echo "Arquivo não encontrado!"
  exit 1
fi

cat "$arquivo" | sed 's/[^[:alpha:]à-ÿÀ-Ÿ]/ /g' | tr ' ' '\n' | sed '/^$/d' \
  | sort | uniq -c | sort -k1,1nr -k2 \
  | while read c w; do
      echo "$w: $c"
    done
