#!/bin/bash

# Install pimcore/demo-basic-twig"
echo "========================================"
echo " INSTALL pimcore/demo-basic-twig"
echo "========================================"
COMPOSER_MEMORY_LIMIT=-1 composer create-project pimcore/demo-basic-twig pimcore
# Set the right owner
chown -R 1000:1000 pimcore

# Setup SQL Database
echo "---------------------------------"
echo " Setup SQL Database"
echo "---------------------------------"
cd pimcore
COMPOSER_MEMORY_LIMIT=-1 ./vendor/bin/pimcore-install --admin-username=admin --admin-password=admin --mysql-host-socket=mysql --mysql-username=pimcore --mysql-password=pimcore --mysql-database=pimcore --no-interaction
# Set the right owner
chown -R 1000:1000 var

# Install php: install web
echo "---------------------------------"
echo " INSTALL php: install web"
echo "---------------------------------"
php bin/console assets:install web

# Without this pimcore is not runnding
# Set right and maximum rights
chown -R 1000:1000 /var/www/html/pimcore/
chmod -R 777 /var/www/html/pimcore/

exit