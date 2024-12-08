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
unzip -o /catalogue.zip &>>$LOG_FILE