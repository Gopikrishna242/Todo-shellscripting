#!/bin/bash

source common.sh


OS_PREREQ

Head "Installing Nginx"
apt install nginx -y &>>$LOG
Stat $?

Head "Installing Nodejs"
apt install nodejs -y &>>$LOG
Stat $?

Head "Installing NPM"
apt install npm -y &>>$LOG
Stat $?

Head "Remove and create directory"
cd /var/www/html/ && rm index.nginx-debian.html && mkdir todo 

Head "Download component"
cd /var/www/html/todo/
git clone https://github.com/Gopikrishna242/frontendd.git

Head "npm install"
cd /var/www/html/todo/frontend && npm install
sed -i -e 's+/var/www/html+/var/www/html/frontend/dist+g' /etc/nginx/sites-enabled/default

