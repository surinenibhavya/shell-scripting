source components/common.sh

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE

echo "Frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE

echo "Clean old data"
rm -rf /usr/share/nginx/html* &>>$LOG_FILE

echo "Extend Frontend content"
cd /tmp
unzip -o frontend.zip &>>$LOG_FILE

echo "Copy extracted content to nginx path"
cp -r frontend-main/static/* /usr/share/nginx/html/ &>>$LOG_FILE

echo "Copy nginx roboshop config"
cp -r frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE

echo "Start nginx"
systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE