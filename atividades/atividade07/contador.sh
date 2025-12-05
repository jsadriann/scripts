#!/bin/bash

conta=1
while true
do

  echo "Processo $NOME - Tempo: $conta segundos"
  conta=$(($conta+1))
  sleep 1
done