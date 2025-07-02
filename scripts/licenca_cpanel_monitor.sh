#!/bin/bash

# Script para monitorar a validade da licença cPanel/WHM via Zabbix
# Autor: Paulo Rocha
# Versão: 1.0

# IP do servidor cPanel
IP="INFORME_O_IP_DO_SERVIDOR"

# Verifica data da última ativação via verify.cpanel.net
DATA=$(curl -sL "https://verify.cpanel.net/index.cgi?ip=${IP}" | grep -oP '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}')

if [[ -z "$DATA" ]]; then
  echo -1
  exit 1
fi

# Converte para timestamp
DATA_TS=$(date -d "$DATA" +%s 2>/dev/null)

if [[ -z "$DATA_TS" ]]; then
  echo -1
  exit 1
fi

NOW_TS=$(date +%s)
DIAS=$(( (NOW_TS - DATA_TS) / 86400 ))

echo "$DIAS"
