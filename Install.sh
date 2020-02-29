#!/bin/bash

# This script takes controll about the installation steps.
#     'git'-tools must be installed
#
# It is expected that you are in a Folder beneth that
# installation files from Github will be loaded
# A Sub-Folder
#      'pimcore' 
# will be created

# Build or/and load the 3 docker-containers as services
#   php     = main container with php stuff and later on pimcore
#   ngnix   = Webserver uses
#   mysql   = holding the database for the content
#
# see docker-compose.ym 
clear
docker-compose build 
docker-compose up -d

# After the containers are create and started the 'pimcore" installation
# will be in within the 'php'-container
docker-compose exec php bash installpimcore.sh

# After resart of the containers pimcore is ready
docker-compose restart

# Finalization > Output Message
clear
echo "======================================================"
echo " PIMCORE is installed now"
echo "-----------------------------------------------------"
echo " Access pimcore:"
echo " Userinterface: http://192.168.1.66:4040/"
echo 
echo " Admin-Section: http://192.168.1.66:4040/admin"
echo "      username & password = admin"
echo "------------------------------------------------------"
echo " Use the following command to shutdown containers"
echo "      docker-compose down"
echo 
echo " Use the following command to start containers/pimcore"
echo "      docker-compose up -d"
echo "======================================================"