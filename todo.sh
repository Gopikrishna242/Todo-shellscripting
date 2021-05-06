#!/bin/bash

source common.sh


OS_PREREQ

Head "Installing Nodejs"
apt install nodejs -y &>>$LOG
Stat $?

Head "Installing NPM"
apt install npm -y &>>$LOG
Stat $?

Head "Cloneing component"
git clone https://github.com/Gopikrishna242/todo.git &>>$LOG
Stat $?

Head "Installing NPM"
cd todo && npm install &>>$LOG
Stat $?

Head "Move service file"
cd todo && mv todo.service /etc/systemd/system
Stat $?

Head "changing Private IP"
sed -i -e 's+redis-private-Ip+/+g' /etc/systemd/system/todo.service

Head "Starting login service"
systemctl daemon-reload && systemctl start todo.service && systemctl enable todo.service && systemctl status todo.service
stat $?
