#!/bin/bash

set -a
source ${1:-.local.ias.env}
source ${2:-.local.postgres.env}
set +a

echo $AUTHENTIK_SERVER_DATA_DIR
echo $AUTHENTIK_REDIS_DATA_DIR
echo $AUTHENTIK_POSTGRES_DATA_DIR


# - n. need to break it down into different environment variable sets 
# - n. set -o allexport
#      set +o allexport
echo "creating directories"

function create_directory_if_not_exist() {

    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi

    #chown -R "$SUDO_USER":"$2" "$1"
    chown -R "$SUDO_USER":"$SUDO_USER" "$1"

    echo "$1"
}
create_directory_if_not_exist "${AUTHENTIK_SERVER_DATA_DIR}"
create_directory_if_not_exist "${AUTHENTIK_SERVER_DATA_DIR}/data"
create_directory_if_not_exist "${AUTHENTIK_SERVER_DATA_DIR}/media"
create_directory_if_not_exist "${AUTHENTIK_SERVER_DATA_DIR}/certs"
create_directory_if_not_exist "${AUTHENTIK_SERVER_DATA_DIR}/custom-templates"
create_directory_if_not_exist "${AUTHENTIK_SERVER_DATA_DIR}/data"
create_directory_if_not_exist "${AUTHENTIK_POSTGRES_DATA_DIR}"
create_directory_if_not_exist "${AUTHENTIK_REDIS_DATA_DIR}" 


echo "Creating network"
netname=identity
../create_docker_network.sh "$netname" "172.20.2.0/24"


echo "creating servers"

docker-compose up -d
