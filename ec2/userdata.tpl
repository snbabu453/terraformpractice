#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
echo "This is coming from terrafrom" >> /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
sudo ufw allow 'nginx http'