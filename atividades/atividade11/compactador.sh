#!/bin/bash

DIRETORIO=$(dialog --stdout --title "Diretório" --inputbox "Digite o caminho do diretório:" 8 50)
if [ $? -ne 0 ] || [ ! -d "$DIRETORIO" ]; then
    dialog --msgbox "Diretório inválido ou cancelado." 6 40
    clear
    exit 1
fi

ITENS=()
while read -r ARQUIVO; do
    ITENS+=("$ARQUIVO" "" "off")
done < <(ls -p "$DIRETORIO" | grep -v /)

if [ ${#ITENS[@]} -eq 0 ]; then
    dialog --msgbox "Nenhum arquivo encontrado neste diretório." 6 40
    clear
    exit 1
fi

SELECAO=$(dialog --stdout --title "Seleção de Arquivos" \
    --checklist "Escolha os arquivos para compactar:" 15 50 10 \
    "${ITENS[@]}")

if [ $? -ne 0 ] || [ -z "$SELECAO" ]; then
    dialog --msgbox "Nenhum arquivo selecionado." 6 40
    clear
    exit 1
fi

METODO=$(dialog --stdout --title "Compressão" \
    --radiolist "Escolha o método:" 10 40 2 \
    "gzip" "(.tar.gz)" on \
    "bzip2" "(.tar.bz2)" off)

if [ $? -ne 0 ]; then clear; exit 1; fi

NOME_SAIDA=$(dialog --stdout --title "Salvar como" --inputbox "Digite o nome do arquivo final (sem extensão):" 8 50)
if [ $? -ne 0 ] || [ -z "$NOME_SAIDA" ]; then clear; exit 1; fi

cd "$DIRETORIO"

ARQUIVOS_LIMPOS=$(echo $SELECAO | sed 's/"//g')

if [ "$METODO" == "gzip" ]; then
    ARQUIVO_FINAL="${NOME_SAIDA}.tar.gz"
    tar -czf "../$ARQUIVO_FINAL" $ARQUIVOS_LIMPOS
else
    ARQUIVO_FINAL="${NOME_SAIDA}.tar.bz2"
    tar -cjf "../$ARQUIVO_FINAL" $ARQUIVOS_LIMPOS
fi

cd - > /dev/null
dialog --title "Sucesso" --msgbox "Arquivo criado com sucesso:\n$ARQUIVO_FINAL" 8 50

clear
