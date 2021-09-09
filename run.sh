#!/bin/sh

php artisan migrate --force
php artisan websocket:serve
