source components/common.sh

echo "Setting up Repo file"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>$LOG_FILE
dnf module disable mysql &>>$LOG_FILE
STAT $?

echo "Downloading mysql"
yum install mysql-community-server -y &>>$LOG_FILE
STAT $?

echo "Start mysql"
systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld &>>$LOG_FILE
STAT $?