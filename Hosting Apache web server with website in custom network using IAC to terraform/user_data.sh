#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl restart httpd
sudo systemctl enable httpd
cd /var/www/html/
wget https://www.free-css.com/assets/files/free-css-templates/download/page294/woody.zip
unzip woody.zip
rm -rf woody.zip
mv -f carpenter-website-template/* .
sudo systemctl restart httpd
sudo systemctl enable httpd
