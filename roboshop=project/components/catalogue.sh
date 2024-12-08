source components/common.sh

echo "Setup NodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE

echo "Install NodeJS"
yum install nodejs -y &>>$LOG_FILE

echo "Create App user"
useradd roboshop &>>$LOG_FILE

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE

echo "Extract catalogue code"
cd /tmp/
unzip -o catalogue.zip &>>$LOG_FILE

echo "Clean old catalogue"
rm -rf  /home/roboshop/catalogue

echo "Copy catalogue content"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE

echo "Install NodeJS Dependencies"
cd /home/roboshop/catalogue
npm install &>>$LOG_FILE

chown roboshop:roboshop /home/roboshop/ -R

echo "Update systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service


echo "Setup catalogue systemd file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service

echo "Start catalogue"
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue