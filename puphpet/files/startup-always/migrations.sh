#!/bin/bash

cd /srv/gibson/public
composer update
php htdocs/index.php migration apply
