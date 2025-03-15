# Prerequisites

To run this project, you’ll need an AWS EC2 instance or a virtual machine with approximately 8 GB of RAM, a 4-core CPU, a Linux operating system, and an internet connection. For this setup, I’ve used an AWS t3.medium instance configured with the default VPC, Amazon Linux AMI (AMI ID: `ami-08b5b3a93ed654d19`), 30 GB of gp3 storage, and a security group allowing ports 22, 7070, 8080, and 9090.

## Host Machine Setup

### Install Git
Update the package manager and install Git on the host:
```bash
sudo yum update -y
sudo yum install git -y
```
### Install Terraform
Install Terraform: Download and set up the latest version of Terrafor:
```bash
terraform_version=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r '.current_version')
curl -O "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip"
unzip terraform_${terraform_version}_linux_amd64.zip
mkdir -p ~/bin
mv terraform ~/bin/
terraform version
```
### Apply code through Terraform
Deploy with Terraform: Use Terraform to provision and deploy the resources on the host
```bash
terraform init
terraform plan
terraform apply
```
# Repositories
This project relies on three main repositories:


Developer Repository:
```bash
 git clone https://github.com/tyagipurshottam/homework-dev.git
```
GitOps Repository:
```bash
git clone https://github.com/tyagipurshottam/homework-dev.git
```
Terraform Repository:
```bash
git clone  https://github.com/tyagipurshottam/homework-dev.git
```

# Security Check

For security validation, we use kube-bench to scan the system for vulnerabilities and ensure a secure deployment.

## Architecture

Below is the architecture diagram illustrating the setup and data flow for this project:
```
[GitHub Repo (Sources)] ----(Build & Deploy)----> [Minikube/Kind Cluster]
                                                    |
    +-----------------------------------------------+---------------------------------------+
    |                                                                                       |
    | [Writer Program] ----(Writes Data every 1s)----> [MySQL Master]                       |
    |    |                                              |                                   |
    |    |                                              |----(Replication)----> [MySQL Slave]
    |    |                                                                                 |
    |    |                                                                                 |
    |    +----(Expose Metrics)----> [Prometheus] ----(Scrape Metrics)----> [Grafana]       |
    |                                                                                      |
    | [Reader Service] ----(HTTP API Call)----> [User]                                     |
    |    |                                                                                 |
    |    +-- [Reader Pod 1] ----(Reads Row Count every 1s)----> [MySQL Slave]              |
    |    +-- [Reader Pod 2] ----(Reads Row Count every 1s)----> [MySQL Slave]              |
    |    +-- [Reader Pod 3] ----(Reads Row Count every 1s)----> [MySQL Slave]              |
    |          |                                                                           |
    |          +----(Expose Metrics)----> [Prometheus]                                     |
    |                                                                                      |
    +---- [Grafana] ----(View Dashboard)----> [User]                                       |

```
