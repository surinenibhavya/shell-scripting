source components/common.sh

echo "Setup YUM repositories for RabbitMQ"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>$LOG_FILE
STAT $?

echo"Install erland and rabbit mq"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>$LOG_FILE
STAT $?

echo "Start RabbitMQ"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo "Add Roboshop user"
rabbitmqctl add_user roboshop roboshop123

# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"