#!/bin/bash

TITULO="Relatório de Status"
VERSAO="1.0"

# 1. Saída limpa
tput clear

tput setaf 4      # azul
tput bold   #negrito
echo "$TITULO"

tput cup 5 10

tput setaf 1      # vermelho
tput smul   #sublinhado
echo "$VERSAO"

tput sgr0 #restaurar

tput cup 8 10
echo "$(date)"

tput cup 10 10
echo "$(whoami)"

# Fim
tput sgr0