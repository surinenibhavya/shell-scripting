# Install MongoDB Manual Steps.
# Ref URL: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
# Setup MongoDB repos.
# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
# ​
# Install Mongo & Start Service.
# # yum install -y mongodb-org
# # systemctl enable mongod
# # systemctl start mongod
# ​
# Update Listen IP address from 127.0.0.1 to 0.0.0.0 in config file
# Config file: /etc/mongod.conf
# then restart the service
# # systemctl restart mongod
#
# ​
# Every Database needs the schema to be loaded for the application to work.
# Download the schema and load it.
# # curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
#
# # cd /tmp
# # unzip mongodb.zip
# # cd mongodb-main
# # mongo < catalogue.js
# # mongo < users.js

source components/common.sh

echo "Download mongodb repo file"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo

echo "Install mongodb"
yum install -y mongodb-org

