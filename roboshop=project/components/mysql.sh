source components/common.sh

echo "Setting Up MySQL Repo"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>$LOG_FILE
STAT $?

echo "Install MySQL Server"
yum install mysql-community-server -y &>>$LOG_FILE
STAT $?

echo "Start MySQL Service"
systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld &>>$LOG_FILE
STAT $?

DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('RoboShop@1');
uninstall plugin validate_password;" >/tmp/pass.sql

echo "Change Default Password"
echo 'show databases;' | mysql -uroot -pRoboShop@1 &>>$LOG_FILE
if [ $? -ne 0 ]; then
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" </tmp/pass.sql &>>$LOG_FILE
fi
STAT $?

echo "Download MySQL Shipping Schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>$LOG_FILE
STAT $?

echo "Extract Schema File"
cd /tmp
unzip -o mysql.zip &>>$LOG_FILE
STAT $?

echo "Load Schema"
mysql -uroot -pRoboShop@1 <mysql-main/shipping.sql  &>>$LOG_FILE
STAT $?