#!/bin/bash

# Obtém o nome do usuário atual
usuario=$(whoami)

# Obtém a data atual (dia, mês e ano)
# %d -> dia | %m -> mês | %Y -> ano com 4 dígitos
data=$(date +"Hoje é um dia lindo,  dia %d, do mês %m do ano de %Y.")

# Monta a saudação completa
mensagem="Olá $usuario,
$data"

echo "$mensagem"

echo "$mensagem" >> saudacao.log
