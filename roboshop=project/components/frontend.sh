# # systemctl enable nginx
# # systemctl start nginx
#
# ​
# Let's download the HTDOCS content and deploy under the Nginx path.
# # curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
# ​
# Deploy the downloaded content in Nginx Default Location.
# # cd /usr/share/nginx/html
# # rm -rf *
# # unzip /tmp/frontend.zip
# # mv frontend-main/static/* .
# # mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE

echo "Frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE

echo "Clean old data"
rm -rf /usr/share/nginx/html* &>>$LOG_FILE

echo "Extend Frontend content"
cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/frontend.zip &>>$LOG_FILE