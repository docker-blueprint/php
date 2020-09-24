#!/bin/bash

if ! [ -f artisan ]; then
    echo "Create new Laravel project..."

    git init

    docker-blueprint composer global require laravel/installer
    docker-blueprint composer create-project laravel/laravel /var/www/html/.laravel
    docker-blueprint composer global remove laravel/installer

    bash -c 'mv -n .laravel/{,.}* .' # Suppress ZSH warnings, always run in bash
    rm -rf .laravel
    
    echo "node_modules" >> .gitignore
    echo "vendor" >> .gitignore
fi

if ! [ -f .env ] && [ -f .env.example ]; then
    cp .env.example .env
    
    docker-blueprint php artisan key:generate
fi

docker-blueprint npm install
