#!/bin/bash

file="index.php"

if [[ ! -f "$file" ]]; then
    touch "$file"
    
    echo "<?php" >> "$file"
    echo "" >> "$file"
    echo "phpinfo();" >> "$file"
fi
