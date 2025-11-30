#!/bin/sh

set -e

command -v openssl > /dev/null 2>&1 || apk add openssl

env_file="./secrets/.env"
prom_file="./secrets/prom_key"


if [ ! -f "$env_file" ]; then
    rand_key=$(openssl rand -hex 32)
    echo "PROMETHEUS_HEX=$rand_key" > "$env_file"
    echo "$rand_key" > "$prom_file"
    echo "generated new PROMETHEUS_HEX"

else
    echo "Prometheus secrets files already exist, skipping generation"
fi
