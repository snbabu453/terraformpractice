sudo curl https://get.docker.com/ | bash

sudo systemctl start docker
sudo systemctl enable  docker
sudo usermod -aG docker ubuntu
