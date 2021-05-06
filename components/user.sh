#!/bin/bash

source components/common.sh


OS_PREREQ

Head "Installing JAVA"
apt-get install openjdk-8-jdk -y &>>$LOG
Stat $?

Head "Installing MAVEN"
apt install maven -y &>>$LOG
Stat $?

Head "clone the repository"
git clone https://github.com/Gopikrishna242/users.git
Stat $?

Head "Maven Build"
cd users && mvn clean package &>>$LOG
Stat $?

Head "rename jar file"
mv /root/Todo-shellscripting/users/target/users-api-0.0.1.jar users.jar
Stat $?

Head "Move service file"
cd /root/Todo-shellscripting/users && mv users.service /etc/systemd/system/
Stat $?

Head "Start the users service"
systemctl daemon-reload && systemctl start users.service && systemctl enable users.service && systemctl status users.service
Stat $?



