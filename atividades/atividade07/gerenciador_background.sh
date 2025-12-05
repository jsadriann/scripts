#!/bin/bash

read -p "Digite um nome para o processo: " NOME
export NOME

./contador.sh &

PID=$!
echo "Processo iniciado com PID: $PID"

sleep 10
kill $PID
echo "Processo $NOME finalizado (PID: $PID)."