#!/bin/bash

source components/common.sh


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
Stat $?

Head "Download component"
cd /var/www/html/todo/
git clone https://github.com/Gopikrishna242/frontendd.git
stat $?

Head "npm install"
cd /var/www/html/todo/frontendd && npm install &>>$LOG
Stat $?

Head "npm build"
cd /var/www/html/todo/frontendd && npm run build &>>$LOG
Stat $?

Head "changing default path"
sed -i -e 's+/var/www/html+/var/www/html/todo/frontendd/dist+g' /etc/nginx/sites-enabled/default
Stat $?

Head "changing private IP of AUTH" 
export AUTH_API_ADDRESS=http://172.31.54.183:8080
Stat $?

Head "changing private IP of TODO" 
export TODOS_API_ADDRESS=http://172.31.62.8:8080
Stat $?

Head "start service"
cd /var/www/html/todo/frontendd && systemctl restart nginx && systemctl enable nginx && npm start
Stat $?


