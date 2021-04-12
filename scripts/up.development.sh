#!/bin/bash

# Generic blueprint initialization code goes here

if [[ ! -d vendor ]]; then
    composer install --no-scripts
fi

if [[ ! -d node_modules ]]; then
    npm run dev
fi

# Return zero exit code explicitly so 'up' command is not interrupted

exit 0
