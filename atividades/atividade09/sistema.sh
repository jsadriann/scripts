#!/bin/bash

function menu() {

    local T_TITULO=$(tput setaf 3)
    local T_OPCAO=$(tput setaf 6)
    local T_RESET=$(tput sgr0) 
    
    tput clear
    
    echo "${T_TITULO}===== MONITOR DE DESEMPENHO =====${T_RESET}"
    echo
    echo "${T_OPCAO}1)${T_RESET} Time On"
    echo "${T_OPCAO}2)${T_RESET} Kernel Logs"
    echo "${T_OPCAO}3)${T_RESET} Virtual Memory"
    echo "${T_OPCAO}4)${T_RESET} CPU per Kernel"
    echo "${T_OPCAO}5)${T_RESET} Memory Used per Process"
    echo "${T_OPCAO}6)${T_RESET} Memory Fisical"
    echo
    echo "${T_OPCAO}7)${T_RESET} Exit"
    echo
}


while true; do

    menu
    
    read -p "informe uma opção: " ESCOLHA

    tput clear
    
    case $ESCOLHA in
        1)
            echo "--- TEMPO LIGADO ---"
            uptime
            ;;
        2)
            echo "--- LOGS DO KERNEL ---"
            dmesg | tail -n 10
            ;;
        3)
            echo "--- MEMÓRIA VIRTUAL ---"
            vmstat 1 10
            ;;
        4)
            echo "--- USO DE CPU POR NÚCLEO ---"
            mpstat -P ALL 1 5
            ;;
        5)
            echo "--- USO DE CPU POR PROCESSO ---"
            pidstat 1 5
            ;;
        6)
            echo "--- MEMÓRIA FÍSICA ---"
            free -m
            ;;
        7)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
    
    echo
    read -n 1 -p "Pressione ENTER para voltar ao menu..."

done
