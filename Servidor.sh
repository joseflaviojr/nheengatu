#!/bin/bash

# Servidor Web - http://localhost:1111/
python -m SimpleHTTPServer 1111 &
PIDS[0]=$!

# Nheengatu
watch -n 5 "./Gerar.sh html" &
PIDS[1]=$!

# Finalização dos processos com CTRL+C
trap "kill -9 ${PIDS[*]}" SIGINT
echo "Pressione CTRL+C para finalizar..."
wait
