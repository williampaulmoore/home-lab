#!/bin/bash

netname=$1

echo "checking network"
if docker network ls | grep -q $netname; then
    echo "removing $netname network"

    adapter_id=$(docker network ls | grep $netname | cut -d ' ' -f 1)
    adapter=$(echo "br-$adapter_id")

    docker network rm $netname

    # Remove the custom rules
    iptables-save | grep -v $adapter | iptables-restore

    # Save the iptables rules to make the changes persistent
    iptables-save > /etc/iptables/rules.v4

fi
