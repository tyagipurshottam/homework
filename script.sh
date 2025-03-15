#!/bin/bash



echo -e "\033[0;32m Update Package\033[0m"
sudo yum update -y 
if [[ $? -eq 0 ]]
    then
       echo "Successfully installed  pkg"
else
        echo -e "\033[0;32m Unable to install Package\033[0m"
    fi

echo -e "\033[0;32m install depandent Package like docker \033[0m"
sudo yum  install  telnet docker -y 
if [[ $? -eq 0 ]]
    then
       echo "Successfully installed  pkg"
else
       echo -e "\033[0;32m Unable to install Package\033[0m"
    fi
sudo systemctl start docker
if [[ $? -eq 0 ]]
    then
       echo "Docker run successfully "
else
       echo -e "\033[0;32m Docker is not running\033[0m"
    fi
sudo chgrp docker $(which docker)
sudo chmod g+s $(which docker)
usermod -aG docker "$USER"
sg "$(id -gn)" -c "groups"
if [[ $? -eq 0 ]]
    then
       echo "Change docker permision to normal user"
else
       echo -e "\033[0;32m Not able to change a permission \033[0m"
    fi
curl -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
if [[ $? -eq 0 ]]
    then
       echo "Successfully installed minikube"
else
       echo -e "\033[0;32m Unable to install minikube\033[0m"
    fi

sudo cp minikube-linux-amd64 /usr/local/bin/minikube
if [[ $? -eq 0 ]]
    then
       echo "Successfully cpoy bimray of minikube"
else
       echo -e "\033[0;32m Unable to  copy  minikube\033[0m"
    fi
sudo chmod 755 /usr/local/bin/minikube
if [[ $? -eq 0 ]]
    then
       echo "Successfully change permission of minikube"
else
       echo -e "\033[0;32m Unable change permision to minikube\033[0m"
    fi
echo -e "\033[0;32m Check minikube version\033[0m"
minikube version


echo -e "\033[0;32m Start minikube \033[0m"
minikube start 
if [[ $? -eq 0 ]]
    then
       echo "Successfully start minukube"
else
       echo -e "\033[0;32m Unable to start minikube\033[0m"
    fi

echo -e "\033[0;32m Install kubectl  package\033[0m"

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
EOF
if [[ $? -eq 0 ]]
    then
       echo "Successfully installed  kubectl"
else
       echo -e "\033[0;32m Unable to install kubect \033[0m"
    fi
echo -e "\033[0;32m Start minikube \033[0m"
sudo yum install -y kubectl
if [[ $? -eq 0 ]]
    then
       echo "Successfully install kubectl"
else
       echo -e "\033[0;32m Unable to install kubectl\033[0m"
    fi


sleep 30
echo -e "\033[0;32m Status minikube \033[0m"
  

minikube addons enable ingress 
if [[ $? -eq 0 ]]
    then
       echo "Successfully enable ingress in  minukube"
else
       echo -e "\033[0;32m Unable to start ingress in  minikube\033[0m"
    fi

minikube status
# terraform_version=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')
# curl -O "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip"
# unzip terraform_${terraform_version}_linux_amd64.zip
# mkdir -p ~/bin
# mv terraform ~/bin/
# terraform version
#kubectl run mysql-client --rm --tty -i --restart='Never' --image  mysql:latest --namespace foo --env MYSQL_ROOT_PASSWORD=password --command -- bash
# rsync -avz -e "ssh -i /Users/purshottamtyagi/Downloads/11march22024.pem" terraform-day-1-project ec2-user@54.196.128.102:~