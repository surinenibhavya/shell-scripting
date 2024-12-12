source components/common.sh

echo "Configure YUM repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
STAT $?

echo "Install RabbitMQ & ErLang"
sudo wget https://github.com/rabbitmq/erlang-rpm/releases/download/v26.0/erlang-26.0-1.el7.x86_64.rpm &>>$LOG_FILE
sudo yum install ./erlang-26.0-1.el7.x86_64.rpm -y &>>$LOG_FILE
sudo yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v26.0/erlang-26.0-1.el7.x86_64.rpm rabbitmq-server -y &>>$LOG_FILE
STAT $?

echo "Start RabbitMQ"
systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $?

echo "Create Application User"
rabbitmqctl list_users | grep roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
  rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
fi
STAT $?

echo "Setup Permissions for App User"
rabbitmqctl set_user_tags roboshop administrator &>>$LOG_FILE && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
STAT $?
