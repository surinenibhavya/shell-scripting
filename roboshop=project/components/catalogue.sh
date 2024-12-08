source components/common.sh

echo "Setup NodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "Install NodeJS"
yum install nodejs -y

echo "Create App user"
useradd roboshop

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"

echo "Extract catalogue code"
cd /tmp/
unzip -o catalogue.zip

echo "Clean old catalogue"
rm -rf  /home/roboshop/catalogue

echo "Copy catalogue content"
cp -r catalogue-main /home/roboshop/catalogue

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