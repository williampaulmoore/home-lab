#!/bin/bash

netname=dns

if docker ps --format '{{.Names}}' | grep -q trust-dns; then
    echo "container exsits: trust-dns"
    exit
fi

../create_docker_network.sh "$netname" "172.20.1.0/24"

echo "creating dns server"
docker run \
    -d \
    --rm \
    --network $netname \
    --ip 172.20.1.2 \
    --dns=8.8.8.8 \
    -v $(pwd)/named.toml:/etc/named.toml \
    -v $(pwd)/sothis.local.zone:/var/named/sothis.local.zone \
    --name trust-dns \
    trustdns/trust-dns

