LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT()
{
 if [ $? -eq 0 ]; then
  echo -e "\e[1;32m SUCCESS\e[0m"
 else
  echo "Fail"
  exit 2
 fi
}

NODEJS()
{
Component=$1
echo "Setup NodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE
STAT $?

echo "Install NodeJS"
yum install nodejs -y &>>$LOG_FILE
STAT $?

echo "Create App user"
id roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
 useradd roboshop&>>$LOG_FILE
fi
STAT $?


echo "Download ${Component} code"
curl -s -L -o /tmp/${Component}.zip "https://github.com/roboshop-devops-project/${Component}/archive/main.zip" &>>$LOG_FILE
STAT $?

echo "Extract ${Component} code"
cd /tmp/
unzip -o ${Component}.zip &>>$LOG_FILE
STAT $?

echo "Clean old ${Component}"
rm -rf  /home/roboshop/${Component} &>>$LOG_FILE
STAT $?

echo "Copy ${Component} content"
cp -r ${Component}-main /home/roboshop/${Component} &>>$LOG_FILE &>>$LOG_FILE
STAT $?

echo "Install NodeJS Dependencies"
cd /home/roboshop/${Component}
npm install &>>$LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R &>>$LOG_FILE

echo "Update systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/'/home/roboshop/${Component}/systemd.service &>>$LOG_FILE
STAT $?

echo "Setup ${Component} systemd file"
mv /home/roboshop/${Component}/systemd.service /etc/systemd/system/${Component}.service &>>$LOG_FILE
STAT $?

echo "Start ${Component}"
systemctl daemon-reload &>>$LOG_FILE
systemctl enable ${Component}&>>$LOG_FILE
systemctl restart ${Component} &>>$LOG_FILE
STAT $

}