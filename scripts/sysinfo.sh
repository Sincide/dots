#!/usr/bin/env bash
# Provides system information summary.

set -Eeuo pipefail
IFS=$'\n\t'

cpu=$(lscpu | awk -F: '/Model name/ {gsub(/^ +/,"",$2); print $2; exit}')
mem=$(free -m | awk '/Mem:/ {print $3}')
totalmem=$(free -m | awk '/Mem:/ {print $2}')
uptime=$(awk '{print int($1)}' /proc/uptime)
disk=$(df -h / | awk 'NR==2{print $5}')

jq -n \
  --arg cpu "$cpu" \
  --argjson mem "$mem" \
  --argjson total "$totalmem" \
  --arg disk "$disk" \
  --argjson up "$uptime" \
  '{cpu:$cpu,mem:{used:mem,total:total},disk:$disk,uptime:up}'
