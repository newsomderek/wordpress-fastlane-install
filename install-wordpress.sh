#!/bin/bash
reset

BLUE='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

printf "\n${GREEN}Install Worpdress in the fastlane${NC}\n\n"

printf "${BLUE}UBUNTU VERSION:${NC} \n"
lsb_release -r # show ubuntu release version
printf "\n${ORANGE}Ubuntu version MUST equal 16.04!${NC}\n\n"

read -p "Press enter to continue..."

reset

# APACHE
while true; do
    printf "\n${BLUE}"
    read -p "Install Apache Server? [Yn]" yn
    print "\n\n"

    case $yn in
        [Yy]* )
            print "${NC}"
            
            sudo apt-get update
            clear
            sudo apt-get install -y apache2

            break;;

        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

print "${NC}"
reset

# MYSQL
while true; do
    printf "\n${BLUE}"
    read -p "Install MySQL? [Yn]" yn
    printf "${NC}\n\n"

    case $yn in
        [Yy]* )
            printf "\n\nPlease set your \"root\" password to something good...please\n\n"
            read -p "Got it?!?! Good. Press enter to continue..."
            clear

            sudo apt-get install -y mysql-server
            clear

            printf "\n\nWe're going to amp up MySQL's security settings next.\n"
            printf "\nWhen asked to enable \"VALIDATE PASSWORD PLUGIN\", keep things simple and choose ${GREEN}No${NC}\n"
            printf "\tIt enforces password requirements. Just have a good password and your all good!\n\n"
            printf "Besides that, you pretty much going to want to choose ${GREEN}YES${NC} on every option.\n\n"
            read -p "Press enter to continue..."
            clear

            sudo mysql_secure_installation

            break;;

        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

reset

# PHP
while true; do
    printf "\n${BLUE}"
    read -p "Install PHP? [Yn]" yn
    printf "${NC}\n\n"

    case $yn in
        [Yy]* )
            sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql

            # edit dir.conf to prioritize php files over html files
            sudo sed -i 's/index.html index.cgi index.pl index.php index.xhtml index.htm/index.php index.html index.cgi index.pl index.xhtml index.htm/g' /etc/apache2/mods-enabled/dir.conf

            sudo systemctl restart apache2

            clear
            printf "\n\nIf all went well, your apache2 status on the next page should look positive:\n\n"

            read -p "Press enter to continue..."
            clear
        
            sudo systemctl status apache2

            printf "\n\n${YELLOW}"
            read -p "Hopefully all looks good above. Press enter to continue..."
            printf "${NC}"
            clear

            sudo echo "<?php phpinfo(); ?>" >> /var/www/html/info.php
            printf "\n\nCheck out an info page we just made, if PHP is setup properly it should be full of PHP-y info!\n\n"
            printf "Before you move on, verify http://<YOUR-IP>/info.php looks good\n\n"
            read -p "Press enter to continue..."

            sudo rm /var/www/html/info.php

            break;;

        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

reset

# FIREWAL
while true; do
    read -p "Configure Firewall? [Yn]" yn
    case $yn in
        [Yy]* )
            echo "-- Configure Firewall Here --"
            break;;

        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

reset

# SSL VIA LET'S ENCRYPT
while true; do
    read -p "Install SLL Certificate with Let's Encrypt (https://letsencrypt.org)? [Yn]" yn
    case $yn in
        [Yy]* )
            echo "-- Install SSL Certificate Here --"
            break;;

        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

reset

# WORDPRESS 
while true; do
    read -p "Install Wordpress? [Yn]" yn
    case $yn in
        [Yy]* )
            echo "-- Install Wordpress Here --"
            break;;

        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done









