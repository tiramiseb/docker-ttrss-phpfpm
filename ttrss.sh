#!/bin/sh

WWW="/var/www/html"

git -C $WWW pull

cp $WWW/config.php-dist $WWW/config.php

# Set values from env vars
env | while read data
do
    name=$(echo $data | cut -d= -f1)
    value=$(echo $data | cut -d= -f2-)
    sed -i "/define(.$name/s|.*|  define('$name', '$value'); // configured by start script|" $WWW/config.php
done

# Provide the correct path for the php executable
sed -i "/define(.PHP_EXECUTABLE/s|.*|  define('PHP_EXECUTABLE', '/usr/local/bin/php'); // configured by start script|" $WWW/config.php

# Start update daemon
su www-data -c "/usr/local/bin/php /var/www/html/update_daemon2.php &"

# Start PHP-FPM
docker-php-entrypoint php-fpm
