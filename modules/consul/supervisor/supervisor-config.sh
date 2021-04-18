#!/usr/bin/with-contenv sh

export NAME="${CONTAINER_MODE:-app}"
export IP="$(hostname -i)"
export ID="$(hostname)"
export PORT=80
