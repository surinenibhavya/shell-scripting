LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE

echo "Frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE

echo "Clean old data"
rm -rf /usr/share/nginx/html* &>>$LOG_FILE

echo "Extend Frontend content"
cd /tmp
unzip /tmp/frontend.zip &>>$LOG_FILE