#!/usr/bin/env bash

cleanup() {
  echo
  echo "Tarefa interrompida. Limpando..."
  [ -n "$task_name" ] && rm -f "${task_name}.tmp"
  exit 1
}

trap cleanup SIGINT

while getopts ":n:t:" opt; do
  case $opt in
    n) task_name="$OPTARG" ;;
    t) task_time="$OPTARG" ;;
    \?) echo "Opção inválida: -$OPTARG" >&2; exit 1 ;;
    :) echo "A opção -$OPTARG requer um argumento." >&2; exit 1 ;;
  esac
done

if [ -z "$task_name" ] || [ -z "$task_time" ]; then
  echo "Uso: $0 -n <nome_tarefa> -t <tempo_em_segundos>"
  exit 1
fi

if ! [[ "$task_time" =~ ^[0-9]+$ ]]; then
  echo "O tempo deve ser um número inteiro."
  exit 1
fi

if [ "$task_time" -gt 15 ]; then
  echo "Tempo máximo permitido: 15 segundos."
  exit 1
fi

# Cria arquivo temporário
touch "${task_name}.tmp"

echo "Iniciando tarefa: $task_name (PID: $$)"

sleep "$task_time"
echo "[${task_time} segundos depois...]"



echo "Tarefa '$task_name' concluída com sucesso."
rm -f "${task_name}.tmp"
