source components/common.sh

echo "Setup NodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE
STAT $?

echo "Install NodeJS"
yum install nodejs -y &>>$LOG_FILE
STAT $?

echo "Create App user"
useradd roboshop
STAT $?

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
STAT $?

echo "Extract catalogue code"
cd /tmp/
unzip -o catalogue.zip &>>$LOG_FILE
STAT $?

echo "Clean old catalogue"
rm -rf  /home/roboshop/catalogue &>>$LOG_FILE
STAT $?

echo "Copy catalogue content"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE &>>$LOG_FILE
STAT $?

echo "Install NodeJS Dependencies"
cd /home/roboshop/catalogue
npm install &>>$LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R &>>$LOG_FILE

echo "Update systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service &>>$LOG_FILE
STAT $?

echo "Setup catalogue systemd file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
STAT $?

echo "Start catalogue"
systemctl daemon-reload &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
systemctl enable catalogue &>>$LOG_FILE
STAT $