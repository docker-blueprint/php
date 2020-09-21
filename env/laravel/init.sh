#!/bin/bash

if ! [ -f .env ] && [ -f .env.example ]; then
    cp .env.example .env
    
    docker-blueprint exec app php artisan key:generate
fi
