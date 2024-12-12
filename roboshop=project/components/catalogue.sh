source components/common.sh

echo "Setup NodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE
STAT $?

echo "Install NodeJS"
yum install nodejs -y &>>$LOG_FILE
STAT $?

echo "Create App user"
 id roboshop &>>$LOG_FILE
 if [ $? -ne 0 ]; then
  useradd roboshop &>>$LOG_FILE
 fi
 STAT $?

 echo "Download catalogue code"
 curl -s -L -o /tmp/$catalogue .zip "https://github.com/roboshop-devops-project/$catalogue /archive/main.zip" &>>$LOG_FILE
 STAT $?

 echo "Extract catalogue  code"
 cd /tmp/
 unzip -o $catalogue.zip &>>$LOG_FILE
 STAT $?

 echo "Clean old catalogue "
 rm -rf  /home/roboshop/catalogue  &>>$LOG_FILE
 STAT $?

 echo "Copy $catalogue  content"
 cp -r ${catalogue }-main /home/roboshop/${catalogue } &>>$LOG_FILE 
 STAT $?
}