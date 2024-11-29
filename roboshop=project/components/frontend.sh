# To Install Nginx.
# #
# # systemctl enable nginx
# # systemctl start nginx
#
# ​
# Let's download the HTDOCS content and deploy under the Nginx path.
# # curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#
# ​
# Deploy the downloaded content in Nginx Default Location.
# # cd /usr/share/nginx/html
# # rm -rf *
# # unzip /tmp/frontend.zip
# # mv frontend-main/static/* .
# # mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
echo "Installing NGINX"
yum install nginx -y >/tmp/roboshop.log

echo "Frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>/tmp/roboshop.log


