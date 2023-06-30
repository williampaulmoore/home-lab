#!/bin/bash

echo "checking containers"
if docker ps --format '{{.Names}}' | grep -q trust-dns; then
    echo "stopping trust-dns"
    docker stop trust-dns
fi

../teardown_docker_network.sh "dns"

