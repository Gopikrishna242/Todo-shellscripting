#!/bin/bash

source components/common.sh


OS_PREREQ

Head "Installing Golang"
apt install golang-go -y &>>$LOG
Stat $?

Head "Download the component code"
git clone https://github.com/Gopikrishna242/login.git
Stat $?

Head "Build process"
cd /root/Todo-shellscripting/login && go build 
Stat $?

Head "go get process"
go get github.com/dgrijalva/jwt-go && go get github.com/labstack/echo && go get github.com/labstack/echo/middleware && go get github.com/labstack/gommon/log && go get github.com/openzipkin/zipkin-go && go get github.com/openzipkin/zipkin-go/middleware/http && go build
Stat $?

Head "Move service file"
cd /root/Todo-shellscripting/login && mv login.service /etc/systemd/system/
Stat $?

Head "Changing private IP in service file"
sed -i -e 's+/user-private-ip+/user.recollect.site+g' /etc/systemd/system/login.service 
Stat $?

Head "Start the service"
cd /etc/systemd/system && systemctl daemon-reload && systemctl start login.service && systemctl enable login.service && systemctl status login.service
Stat $?
