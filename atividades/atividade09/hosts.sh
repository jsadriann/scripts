#!/bin/bash

DB_FILE="hosts.db"

host=""
ip=""
action=""

funcAdd() {

    touch "$DB_FILE"
    
    if grep -q "^$1 " "$DB_FILE"; then
        echo "Erro: O host '$1' já existe no $DB_FILE." >&2
        return 1
    fi
    
    echo "$1 $2" >> "$DB_FILE"
    echo "Adicionado: $1 -> $2"
}

funcRemove() {
    if [ ! -f "$DB_FILE" ]; then
         echo "Erro: Arquivo $DB_FILE não encontrado." >&2
         return 1
    fi
    
    sed -i "/^$1 /d" "$DB_FILE"
    echo "Removido: $1"
}

funcList() {
    if [ ! -f "$DB_FILE" ] || [ ! -s "$DB_FILE" ]; then
        echo "Arquivo $DB_FILE está vazio."
        return
    fi
    
    printf "%-25s %s\n----------------------------\n" "HOSTNAME" "IP"

    cat "$DB_FILE"
}


funcSearchReverse() {
    if [ ! -f "$DB_FILE" ]; then
         echo "Arquivo $DB_FILE está vazio." >&2
         return 1
    fi

    grep " $1$" "$DB_FILE" | cut -d' ' -f1
}

if [[ "$1" != -* ]] && [ "$#" -eq 1 ]; then
    if [ ! -f "$DB_FILE" ]; then exit 1; fi

    grep "^$1 " "$DB_FILE" | cut -d' ' -f2
    exit 0
fi

while getopts "a:i:d:lr:" opt; do
    case $opt in
        a)
            host="$OPTARG"
            if [ "$action" = "" ]; 
                then 
                    action="add"; 
                fi
            ;;
        i)
            ip="$OPTARG"
            if [ "$action" = "" ]; 
                then 
                    action="add"; 
                fi
            ;;
        d)
            action="remove"
            host="$OPTARG"
            ;;
        l)
            action="list"
            ;;
        r)
            action="reverse"
            ip="$OPTARG"
            ;;
        \?) echo "Opção inválida -$OPTARG" >&2; exit 1;;
        :) echo "Opção -$OPTARG requer um argumento." >&2; exit 1;;
    esac
done

shift $((OPTIND -1))



case $action in
    add)
        if [ -z "$host" ] || [ -z "$ip" ]; then
            echo "Erro: Adicionar requer as opções -a <hostname> e -i <IP>" >&2
            exit 1
        fi
        funcAdd "$host" "$ip"
        ;;
    remove)
        funcRemove "$host"
        ;;
    list)
        funcList
        ;;
    reverse)
        funcSearchReverse "$ip"
        ;;
    *)
        
        if [ "$#" -eq 0 ]; then
             echo "Uso: ./hosts.sh [-a host -i ip | -d host | -l | -r ip | host]"
             exit 1
        fi
        ;;
esac
