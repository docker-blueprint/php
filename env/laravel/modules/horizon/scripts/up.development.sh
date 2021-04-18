#!/bin/bash

version_suffix=""

if [[ -f composer.json ]]; then
    existing_version=$(
        cat composer.json |
            grep 'laravel/horizon' | cut -d':' -f2 | sed -E 's/.*"(.*?)".*/\1/'
    )

    if [[ -n "$existing_version" ]]; then
        version_suffix=":$existing_version"
    fi
fi

COMPOSER_MEMORY_LIMIT=${BLUEPRINT_COMPOSER_MEMORY_LIMIT-'-1'}

composer require laravel/horizon$version_suffix

php artisan horizon:install
