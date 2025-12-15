#!/bin/bash

verificar_cancelamento() {
    if [ $? -ne 0 ]; then
        dialog --msgbox "Operação cancelada pelo usuário." 6 40
        clear
        exit 1
    fi
}

NOME=$(dialog --stdout --title "Identificação" --inputbox "Digite o Nome do Cliente:" 8 40)
verificar_cancelamento

if [ -z "$NOME" ]; then
    dialog --msgbox "Erro: O nome não pode estar vazio." 6 40
    clear
    exit 1
fi


LANCHE=$(dialog --stdout --title "Prato Principal" \
    --radiolist "Escolha o prato principal:" 10 40 3 \
    "Hambúrguer" "" off \
    "Pizza" "" off \
    "Pastel" "" off)
verificar_cancelamento

ADICIONAIS=$(dialog --stdout --title "Adicionais" \
    --checklist "Selecione os adicionais:" 12 40 4 \
    "Refrigerante" "" off \
    "Suco" "" off \
    "Batata Frita" "" off \
    "Molho Extra" "" off)
verificar_cancelamento


dialog --title "Confirmação" --yesno "O seu pedido está correto?" 7 40
RESPOSTA=$?


if [ $RESPOSTA -ne 0 ]; then
    dialog --msgbox "Pedido Cancelado" 6 40
    clear
    exit 0
fi

TEXTO_RECIBO="Resumo do Pedido:\n\nNome do Cliente: $NOME\nPrato Principal: $LANCHE\nAdicionais: $ADICIONAIS"

dialog --title "Recibo Final" --msgbox "$TEXTO_RECIBO" 12 50

clear