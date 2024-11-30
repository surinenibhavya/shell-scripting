source components/common.sh

echo "set up Node JS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE

yum install nodejs -y

useradd roboshop

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"

cd /home/roboshop
unzip -o /tmp/catalogue.zip

rm -rf  /home/roboshop/catalogue

cp -r catalogue.main /home/roboshop/catalogue

cd /home/roboshop/catalogue

npm install

echo "HI"