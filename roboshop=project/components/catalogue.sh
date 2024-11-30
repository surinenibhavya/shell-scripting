source components/common.sh

echo "Setup Node JS file"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE

echo "Install Node JS"
yum install nodejs -y &>>$LOG_FILE

echo "Create app user"
useradd roboshop &>>$LOG_FILE

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE

echo "Extract catalogue code"
cd /tmp/
unzip -o catalogue.zip &>>$LOG_FILE

echo "Clean old catalogue"
rm -rf /home/roboshop/catalogue

echo "Copy catalogue code"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE

echo "Install Node JS dependencies"
cd /home/roboshop/catalogue
npm install &>>$LOG_FILE