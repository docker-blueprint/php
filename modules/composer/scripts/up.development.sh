#!/bin/bash

if [[ ! -f composer.json ]]; then
    composer init
fi

if [[ ! -d vendor ]]; then
    composer install --no-scripts
fi
