source components/common.sh

echo "Set up Node JS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE

echo "Install Nodejs"
yum install nodejs -y &>>$LOG_FILE

echo "Create App user"
useradd roboshop &>>$LOG_FILE

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE

echo "Extract catalogue code"
cd /home/roboshop
unzip -o /tmp/catalogue.zip &>>$LOG_FILE

echo "Clean old catalgue"
rm -rf  /home/roboshop/catalogue &>>$LOG_FILE

echo "Copy catalogue code"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE

echo "Install nodejs dependencies"
cd /home/roboshop/catalogue
npm install &>>$LOG_FILE

chown roboshop:roboshop /home/roboshop/ -R

echo "Update System file"
sudo sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop-internal/' /home/roboshop/catalogue/systemd.service

echo "Setup catalogue file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service

echo "Start catalogue"
systemctl daemon-reload systemctl start catalogue systemctl enable catalogue

echo "Checking MongoDB Service"
systemctl status mongod

echo "Checking MongoDB Connection"
nc -zv mongodb.roboshop-internal 27017

echo "Checking MongoDB DNS Resolution"
ping -c 4 mongodb.roboshop-internal


