source components/common.sh

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi

echo "Frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi

echo "Clean old data"
rm -rf /usr/share/nginx/html* &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi

echo "Extend Frontend content"
cd /tmp
unzip -o frontend.zip &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi

echo "Copy Extracted Content to Nginx Path"
cp -r frontend-main/static/* /usr/share/nginx/html/ &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi

echo "Copy nginx roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi

echo "Start nginx"
systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi
