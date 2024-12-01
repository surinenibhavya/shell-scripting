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

sudo sed -i -e 's/MONGO_DNSNAME/172.31.32.192/' /home/roboshop/catalogue/systemd.service

sudo cat /home/roboshop/catalogue/systemd.service



