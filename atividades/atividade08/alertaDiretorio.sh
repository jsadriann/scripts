#!/bin/bash

intervalo=$1
diretorio=$2
log="dirSensors.log"

anterior=$(ls "$diretorio")
qtd_anterior=$(echo "$anterior" | wc -w)

while true; do

    atual=$(ls "$diretorio")
    qtd_atual=$(echo "$atual" | wc -w)

    if [ "$qtd_atual" -ne "$qtd_anterior" ]; then
        data=$(date '+%d-%m-%Y %H:%M:%S')

        add=$(comm -13 <(echo "$anterior" | sort) <(echo "$atual" | sort))
        sub=$(comm -23 <(echo "$anterior" | sort) <(echo "$atual" | sort))

        msg="[$data] Alteração! $qtd_anterior --> $qtd_atual."

        if [ -n "$add" ]; then
            msg="$msg Adicionados: $(echo $add | sed 's/, $//')."
        fi
        if [ -n "$sub" ]; then
            msg="$msg Removidos: $(echo $sub | sed 's/, $//')."
        fi

        echo "$msg" | tee -a "$log"
    fi

    sleep "$intervalo"

    anterior="$atual"
    qtd_anterior="$qtd_atual"
done
