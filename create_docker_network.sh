#!/bin/bash

netname=$1
subnet=$2

# if the dns network exists assume it is already setup and exit
if  docker network ls | grep -q $netname; then
    echo "network exists : [$netname]"
    exit
fi

echo "creating network"
docker network create --subnet=$subnet $netname 

adapter_id=$(docker network ls | grep $netname | cut -d ' ' -f 1)
adapter=$(echo "br-$adapter_id")


# Find the position to insert the custom rule
DOCKER_ISOLATION_CHAIN="DOCKER-USER"
POSITION=$(iptables -L "$DOCKER_ISOLATION_CHAIN" --line-numbers | grep -oP '^\d+' | tail -n 1)

# Insert the custom rule at the appropriate position
iptables -I "$DOCKER_ISOLATION_CHAIN" $POSITION -i $adapter -j ACCEPT
iptables -I "$DOCKER_ISOLATION_CHAIN" $POSITION -o $adapter -j ACCEPT

# Save the iptables rules to make them persistent
iptables-save > /etc/iptables/rules.v4

