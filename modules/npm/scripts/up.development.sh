#!/bin/bash

if [[ ! -f package.json ]]; then
    npm init
fi

if [[ ! -d node_modules ]]; then
    npm install
fi
