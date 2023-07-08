#!/bin/bash

set -a
source ${2:-.local.ias.env}
source ${3:-.local.postgres.env}
set +a

docker-compose down

../teardown_docker_network.sh "identity"


if [ "$1"  = "teardown-full" ]; then

    echo "Deleting directories"
    rm -rf "${AUTHENTIK_SERVER_DATA_DIR}"
    rm -rf "${AUTHENTIK_POSTGRES_DATA_DIR}"
    rm -rf "${AUTHENTIK_REDIS_DATA_DIR}"

fi

