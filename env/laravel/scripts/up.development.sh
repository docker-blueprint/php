#!/bin/bash

if [[ ! -f artisan ]]; then

    PROJECT_DIR=.laravel-project

    composer create-project laravel/laravel $PROJECT_DIR

    rm -rf vendor

    mv $PROJECT_DIR/* . 2>/dev/null
    mv $PROJECT_DIR/.* . 2>/dev/null

    rm -rf $PROJECT_DIR

    npm install

fi

if [[ ! -f .env ]] && [[ -f .env.example ]]; then
    cp .env.example .env
fi
