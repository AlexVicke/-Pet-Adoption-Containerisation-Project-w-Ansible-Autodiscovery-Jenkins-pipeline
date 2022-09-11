#####################################################################
###############   VPC MODULE    #####################################
#####################################################################


##################################################################
# CREATE VPC

resource "aws_vpc" "PACAAD1_RAFV_VPC" {
  cidr_block       = var.VPC_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.VPC_name
  }
}

data "aws_vpc" "PACAAD1_RAFV_VPC" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_VPC"]
  }
  depends_on = [
    aws_vpc.PACAAD1_RAFV_VPC
  ]
}

##################################################################
# CREATE PUBLIC SUBNET1

resource "aws_subnet" "PACAAD1_RAFV_PUB_SN1" {
  vpc_id            = aws_vpc.PACAAD1_RAFV_VPC.id
  cidr_block        = var.PUB_SN1_cidr
  availability_zone = var.az_A
  tags = {
    Name = var.PUB_SN1_name
  }
}

data "aws_subnet" "PACAAD1_RAFV_PUB_SN1" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_PUB_SN1"]
  }
  depends_on = [
    aws_subnet.PACAAD1_RAFV_PUB_SN1
  ]
}

##################################################################
#CREATE PUBLIC SUBNET2

resource "aws_subnet" "PACAAD1_RAFV_PUB_SN2" {
  vpc_id            = aws_vpc.PACAAD1_RAFV_VPC.id
  cidr_block        = var.PUB_SN2_cidr
  availability_zone = var.az_B

  tags = {
    Name = var.PUB_SN2_name
  }
}

data "aws_subnet" "PACAAD1_RAFV_PUB_SN2" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_PUB_SN2"]
  }
  depends_on = [
    aws_subnet.PACAAD1_RAFV_PUB_SN2
  ]
}


##################################################################
#CREATE PRIVATE SUBNET1

resource "aws_subnet" "PACAAD1_RAFV_PRV_SN1" {
  vpc_id            = aws_vpc.PACAAD1_RAFV_VPC.id
  cidr_block        = var.PRV_SN1_cidr
  availability_zone = var.az_A

  tags = {
    Name = var.PRV_SN1_name
  }
}

data "aws_subnet" "PACAAD1_RAFV_PRV_SN1" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_PRV_SN1"]
  }
  depends_on = [
    aws_subnet.PACAAD1_RAFV_PRV_SN1
  ]
}

##################################################################
#CREATE PRIVATE SUBNET2

resource "aws_subnet" "PACAAD1_RAFV_PRV_SN2" {
  vpc_id            = aws_vpc.PACAAD1_RAFV_VPC.id
  cidr_block        = var.PRV_SN2_cidr
  availability_zone = var.az_B

  tags = {
    Name = var.PRV_SN2_name
  }
}

data "aws_subnet" "PACAAD1_RAFV_PRV_SN2" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_PRV_SN2"]
  }
  depends_on = [
    aws_subnet.PACAAD1_RAFV_PRV_SN2
  ]
}


##################################################################
#CREATE INTERNET GATEWAY

resource "aws_internet_gateway" "PACAAD1_RAFV_IGW" {
  vpc_id = aws_vpc.PACAAD1_RAFV_VPC.id
  tags = {
    Name = var.IGW_name
  }
}

##################################################################
#CREATE ELASTIC IP FOR NATGw

resource "aws_eip" "PACAAD1_RAFV_EIP" {
  depends_on = [aws_internet_gateway.PACAAD1_RAFV_IGW]
  vpc        = true
  tags = {
    Name = var.EIP_name
  }
}

##################################################################
#CREATE NAT GATEWAY FOR PRIVATE SUBNET

resource "aws_nat_gateway" "PACAAD1_RAFV_NAT_GW" {
  depends_on    = [aws_internet_gateway.PACAAD1_RAFV_IGW]
  allocation_id = aws_eip.PACAAD1_RAFV_EIP.id
  subnet_id     = aws_subnet.PACAAD1_RAFV_PUB_SN1.id
  tags = {
    Name = var.NAT_name
  }
}

##################################################################
#CREATE PUBLIC ROUTE TABLE

resource "aws_route_table" "PACAAD1_RAFV_PUB_RT" {
  vpc_id = aws_vpc.PACAAD1_RAFV_VPC.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.PACAAD1_RAFV_IGW.id
  }
  tags = {
    Name = var.PUB_RT_name
  }
}

##################################################################
#CREATE PUBLIC Sbnt1 w/Pub ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "PACAAD1_RAFV_PUB_SN1_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_RAFV_PUB_SN1.id
  route_table_id = aws_route_table.PACAAD1_RAFV_PUB_RT.id
}

##################################################################
#CREATE PUBLIC Sbnt2 w/Pub ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "PACAAD1_RAFV_PUB_SN2_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_RAFV_PUB_SN2.id
  route_table_id = aws_route_table.PACAAD1_RAFV_PUB_RT.id
}

##################################################################
#CREATE PRIVATE ROUTE TABLE

resource "aws_route_table" "PACAAD1_RAFV_PRV_RT" {
  vpc_id = aws_vpc.PACAAD1_RAFV_VPC.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_nat_gateway.PACAAD1_RAFV_NAT_GW.id
  }
  tags = {
    Name = var.PRV_RT_name
  }
}

##################################################################
#CREATE PRIVATE Sbnt1 w/Prv ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "PACAAD1_RAFV_PRV_SN1_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_RAFV_PRV_SN1.id
  route_table_id = aws_route_table.PACAAD1_RAFV_PRV_RT.id
}

##################################################################
#CREATE PRIVATE Sbnt2 w/Prv ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "PACAAD1_RAFV_PRV_SN2_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_RAFV_PRV_SN2.id
  route_table_id = aws_route_table.PACAAD1_RAFV_PRV_RT.id
}




#####################################################################
###############   Keypair MODULE   ##################################
#####################################################################


##################################################################
#Utilise created Keypair

resource "aws_key_pair" "PACAAD1_RAFV" {
  key_name   = var.keypair_name
  public_key = file(var.path-to-publickey)
}



#####################################################################
###############   SecurityGroups MODULE    ##########################
#####################################################################

# Provision Jenkins and Docker_host SecurityGroup
resource "aws_security_group" "JenDoc_RAFV_SG" {
  name        = var.JenDoc_RAFV_SG_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.PACAAD1_RAFV_VPC.id
  
  ingress {
    description = "SSH from PACAAD1_RAFV_VPC"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "Allow custom_http from PACAAD1_RAFV_VPC"
    from_port   = var.Custom_http
    to_port     = var.Custom_http
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  ingress {
    description = "Allow http from PACAAD1_RAFV_VPC"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
  tags = {
    Name = var.JenDoc_RAFV_SG_name
  }
}

data "aws_security_group" "JenDoc_RAFV_SG" {
  filter {
    name   = "tag:Name"
    values = ["JenDoc_RAFV_SG"]
  }
  depends_on = [
    aws_security_group.JenDoc_RAFV_SG
  ]
}


# Provision Bastion_host and Ansible_node Security_Group
resource "aws_security_group" "BasAns_RAFV_SG" {
  name        = var.BasAns_RAFV_SG_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.PACAAD1_RAFV_VPC.id
  
  ingress {
    description = "SSH from PACAAD1_RAFV_VPC"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
    #SHOULD THIS CIDR BLOCK SHOULD NOT BE CONFIGURED TO VPC_CIDR INSTEAD?
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
  tags = {
    Name = var.BasAns_RAFV_SG_name
  }
}

data "aws_security_group" "BasAns_RAFV_SG" {
  filter {
    name   = "tag:Name"
    values = ["BasAns_RAFV_SG"]
  }
  depends_on = [
    aws_security_group.BasAns_RAFV_SG
  ]
}

# Create Database_Security Group
resource "aws_security_group" "DB_RAFV_SG" {
  name        = var.DB_RAFV_SG_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.PACAAD1_RAFV_VPC.id
  
  ingress {
    description = "SSH from PACAAD1_RAFV_VPC"
    from_port   = var.mysql_port
    to_port     = var.mysql_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
  tags = {
    Name = var.DB_RAFV_SG_name
  }
}

data "aws_security_group" "DB_RAFV_SG" {
  filter {
    name   = "tag:Name"
    values = ["DB_RAFV_SG"]
  }
  depends_on = [
    aws_security_group.DB_RAFV_SG
  ]
}



#####################################################################
###############   Bastion Host MODULE    ############################
#####################################################################

resource "aws_instance" "PACAAD1_RAFV_Bastion_Host" {
  ami           = var.Bastion_rhel_ami
  instance_type = var.Bastion_instance_type
  subnet_id     = aws_subnet.PACAAD1_RAFV_PUB_SN1.id
  #subnet_id    = var.Bastion_subnet_id
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.BasAns_RAFV_SG.id]
  #vpc_security_group_ids      = [var.Bastion_vpc_security_group_ids]
  associate_public_ip_address = var.Bastion_associate_public_ip_address
  provisioner "file" {
    source      = "~/Keypairs/AutodiscoveryPA"
    destination = "/home/ec2-user/AutodiscoveryPA"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/Keypairs/AutodiscoveryPA")
    host        = "${self.public_ip}"
  }
  user_data = <<-EOF
#!/bin/bash
sudo hostnamectl set-hostname Bastion
EOF
  tags = {
    Name = var.PACAAD1_RAFV_Bastion_Host_Name
  }
}

data "aws_instance" "PACAAD1_RAFV_Bastion_Host" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_Bastion_Host"]
  }
  depends_on = [
    aws_instance.PACAAD1_RAFV_Bastion_Host
  ]
}



#####################################################################
###############   JENKINS MODULE    #################################
#####################################################################

resource "aws_instance" "PACAAD1_RAFV_Jenkins_Host" {
  ami           = var.Jenkins_rhel_ami
  instance_type = var.Jenkins_instance_type
  subnet_id     = aws_subnet.PACAAD1_RAFV_PRV_SN2.id
  #subnet_id                   = var.Jenkins_Subnet_id
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.JenDoc_RAFV_SG.id]
  #vpc_security_group_ids      = [var.Jenkins_vpc_security_group_ids]
  associate_public_ip_address = var.Jenkins_associate_public_ip_address

  user_data = <<-EOF

#!/bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install wget -y
sudo yum install git -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install fontconfig -y
sudo yum install java-11-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# sudo yum install docker-ce -y
# sudo systemctl start docker
echo "license_key: 18b989848e83ee998df70e98b20b815c02b0NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo yum install sshpass -y
sudo su
echo Admin123@ | passwd ec2-user --stdin
echo "ec2-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service sshd reload
sudo chmod -R 700 .ssh/
sudo chown -R ec2-user:ec2-user .ssh/
sudo su - ec2-user -c "ssh-keygen -f ~/.ssh/jenkinskey_rsa -t rsa -b 4096 -m PEM -N ''"
sudo bash -c ' echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'

sudo usermod -aG docker jenkins
sudo usermod -aG docker jenkins ec2-user
sudo service sshd restart
sudo hostnamectl set-hostname Jenkins
EOF

  tags = {
    Name = var.PACAAD1_RAFV_Jenkins_Host_Name
  }
}

data "aws_instance" "PACAAD1_RAFV_Jenkins_Host" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_Jenkins_Host"]
  }
  depends_on = [
    aws_instance.PACAAD1_RAFV_Jenkins_Host
  ]
}


#####################################################################
###############   DOCKER MODULE    ##################################
#####################################################################

# Create Docker host Server
resource "aws_instance" "PACAAD1_RAFV_Docker_Host" {
  ami           = var.Docker_rhel_ami
  instance_type = var.Docker_instance_type
  subnet_id     = aws_subnet.PACAAD1_RAFV_PRV_SN1.id
  #subnet_id                   = var.Docker_Subnet_id
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.JenDoc_RAFV_SG.id]
  #vpc_security_group_ids      = [var.Docker_vpc_security_group_ids]
  associate_public_ip_address = var.Docker_associate_public_ip_address

  user_data = <<-EOF
#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update -y
sudo yum install docker-ce -y
sudo yum install docker-ce-cli -y
sudo yum install containerd.io -y
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo alternatives --set python /usr/bin/python3
sudo pip3 install docker-py 
sudo systemctl start docker
sudo systemctl enable docker
echo "license_key: 18b989848e83ee998df70e98b20b815c02b0NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo usermod -aG docker ec2-user
docker pull hello-world
sudo hostnamectl set-hostname Docker
EOF

  tags = {
    Name = var.PACAAD1_RAFV_Docker_Host_Name
  }
}

data "aws_instance" "PACAAD1_RAFV_Docker_Host" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_Docker_Host"]
  }
    depends_on = [
    aws_instance.PACAAD1_RAFV_Docker_Host
  ]
}


#####################################################################
###############   IAM + Ansible MODULE    ###########################
#####################################################################

#######NOTE IAM ROLE AND INSTANCE CREATED IN THIS MODULE TO HAVE CONNECTION WITH
#ANSIBLE HOST INSTANCE WHILE PROVISIONING ----- SEE LINE 79 BELOW###############
################################################################################

################################################################################
# IAM ROLE
################################################################################
# Provision IAM role for Ansible Host
resource "aws_iam_role" "PACAAD1_RAFV_Ansible_IAM_role" {
  name               = "PACAAD1_RAFV_Ansible_IAM_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.PACAAD1_RAFV_Ansible_IAM_role_policy.json
}

################################################################################
# Create Policy attachment for Ansible IAM role
resource "aws_iam_role_policy_attachment" "PACAAD1_Ansible_IAM_role_policy_att" {
  role       = aws_iam_role.PACAAD1_RAFV_Ansible_IAM_role.name
  policy_arn = aws_iam_policy.PACAAD1_RAFV_Ansible_IAM_policy.arn
}


################################################################################
# Create Instance profile for Ansible IAM role
resource "aws_iam_instance_profile" "PACAAD1_RAFV_Ansible_IAM_instance_profile" {
  name = "PACAAD1_RAFV_Ansible_IAM_instance_profile"
  role = aws_iam_role.PACAAD1_RAFV_Ansible_IAM_role.name
}


################################################################################
# Provision Ansible IAM assume role policy
data "aws_iam_policy_document" "PACAAD1_RAFV_Ansible_IAM_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


################################################################################
# Provision Ansible IAM role policy
resource "aws_iam_policy" "PACAAD1_RAFV_Ansible_IAM_policy" {
  name        = "PACAAD1_RAFV_Ansible_IAM_policy"
  description = "Ansible Role policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


################################################################################
# ANSIBLE SERVER
################################################################################

# Provision Ansible Host
resource "aws_instance" "PACAAD1_RAFV_Ansible_Node" {
  ami           = var.Ansible_rhel_ami
  instance_type = var.Ansible_instance_type
  key_name      = var.keypair_name
  subnet_id     = aws_subnet.PACAAD1_RAFV_PRV_SN1.id
  #subnet_id                   = var.Ansible_Subnet_id
  vpc_security_group_ids = [aws_security_group.BasAns_RAFV_SG.id]
  # vpc_security_group_ids      = [var.Ansible_vpc_security_group_ids]
  associate_public_ip_address = var.Ansible_associate_public_ip_address
  iam_instance_profile        = aws_iam_instance_profile.PACAAD1_RAFV_Ansible_IAM_instance_profile.id

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install python3.8 -y
sudo alternatives --set python /usr/bin/python3.8
sudo yum -y install python3-pip
sudo yum install ansible -y
pip3 install ansible --user
sudo chown ec2-user:ec2-user /etc/ansible
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo yum install -y yum-utils
#NEW RELIC SETUP
echo "license_key: 18b989848e83ee998df70e98b20b815c02b0NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
#SSH INSTALLATION
sudo yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/sshpass-1.06-2.el7.x86_64.rpm
sudo yum install sshpass -y
sudo su
echo Admin123@ | passwd ec2-user --stdin
echo "ec2-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service sshd reload
sudo chmod -R 700 .ssh/
sudo chown -R ec2-user:ec2-user .ssh/
sudo su - ec2-user -c "ssh-keygen -f ~/.ssh/pap2anskey_rsa -t rsa -N ''"
sudo bash -c ' echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
sudo su - ec2-user -c 'sshpass -p "Admin123@" ssh-copy-id -i /home/ec2-user/.ssh/pap2anskey_rsa.pub ec2-user@${data.aws_instance.PACAAD1_RAFV_Docker_Host.public_ip} '
ssh-copy-id -i /home/ec2-user/.ssh/pap2anskey_rsa.pub ec2-user@localhost
#UNZIP INSTALLATION
sudo dnf install unzip
#AWS CLI SETUP
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
./aws/install -i /usr/local/aws-cli -b /usr/local/bin
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
sudo ln -svf /usr/local/bin/aws /usr/bin/aws
#DOCKER HUB CONFIGURATION
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user
#CHANGE OWNERSHIP OF DIRECTORY TO EC2-USER
cd /etc
sudo chown ec2-user:ec2-user /ansible/hosts
#CONFIGURATION OF PLAYBOOK FOR THIS INSTANCE
cat <<EOT>> /etc/ansible/Myplaybook.yaml
---
- hosts: webservers
  become: true
  vars:
    create_containers: 1
    default_container_name: my-app
    default_container_image: cloudhight/pipeline:1.0.0
    default_container_command: sleep 1d
    default_container_port: 8085
    defaul_host_port: 8080
  tasks:
   - name: login to dockerhub
     command: docker login -u cloudhight -p CloudHight_Admin123@
   - name: Stop any container running
     command: docker stop pet-adoption-container
     ignore_errors: yes
   - name: Remove stopped container
     command: docker rm pet-adoption-container
     ignore_errors: yes
   - name: Remove docker image
     command: docker rmi cloudhight/pipeline:1.0.0

     ignore_errors: yes
  tasks:
    - name: Pull default Docker image
      docker_image:
        name: "{{ default_container_image }}"
        source: pull
    - name: Restart a container
      docker_container:
        name: pet-adoption-container
        image: cloudhight/pipeline:1.0.0
        state: started
        ports:
         - "8080:8085"
EOT
sudo hostnamectl set-hostname Ansible
#AUTODISCOVERY SETUP
# This script automatically update ansible host inventory
TAG='Tomcat-test'
AWSBIN='/usr/local/bin/aws'
awsDiscovery() {
	$AWSBIN ec2 describe-instances --filters Name=tag:aws:autoscaling:groupName,Values=dockerHostASG \
		--query Reservations[].Instances[].NetworkInterfaces[*].{PrivateIpAddresses:PrivateIpAddress} > /etc/ansible/ips.list
	}
inventoryUpdate() {
	echo > /etc/ansible/hosts 
  	echo [webservers] > /etc/ansible/hosts
	for instance in `cat /etc/ansible/ips.list`
	do
		ssh-keyscan -H $instance >> ~/.ssh/known_hosts
echo "
$instance ansible_user=ec2-user ansible_ssh_private_key_file=/etc/ansible/pap2anskey_rsa.pem
" >> /etc/ansible/hosts
       done
}
instanceUpdate() {
  sleep 30
  ansible-playbook MyPlaybook.yaml 
  sleep 30
}
awsDiscovery
inventoryUpdate
#instanceUpdate
sudo chmod 755 discovery.sh /etc/ansible
ssh-keygen 

EOF

  tags = {
    Name = var.PACAAD1_RAFV_Ansible_Node_Name
  }
}


data "aws_instance" "PACAAD1_RAFV_Ansible_Node" {
  filter {
    name   = "tag:Name"
    values = ["PACAAD1_RAFV_Ansible_Node"]
  }
  depends_on = [
    aws_instance.PACAAD1_RAFV_Ansible_Node
  ]
}


# #####################################################################
# ###########   RUN THIS CODE AFTER 1ST RUN TO CREATE HA ##############
# #####################################################################




# ##################################################################
# #Add a Jenkins Load Balancer
# resource "aws_lb" "PACAAD1_RAFV_Jenkins_lb" {
#   name               = var.Jenkins_Lb_name
#   internal           = false
#   load_balancer_type = "Network"
#   security_groups            = [var.LB_securitygroup_id]
#   subnets                    = [aws_subnet.PACAAD1_RAFV_PUB_SN1.id, aws_subnet.PACAAD1_RAFV_PUB_SN2.id]
#   enable_deletion_protection = false

#   listener {
#     instance_port     = 8080
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "TCP:8080"
#     interval            = 30
#   }

#   instances                   = [aws_instance.PACAAD1_RAFV_Jenkins_Host.id]
#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400

#   tags = {
#     Name = var.Jenkins_Lb_name
#   }
# }


# #Create a Target Group for Jenkins Load Balancer
# resource "aws_lb_target_group" "PACAAD1_RAFV_Jenkins_Tg" {
#   name     = var.Jenkins_Lb_Tg_name
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id

#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 5
#     interval            = 30
#     timeout             = 5
#     path                = "/"
#   }
# }

# #WHY A GROUP ATTACHMENT AND LISTENER IS NOT NEEDED HERE?
# #Create Target group attachment for Jenkins lb
# resource "aws_lb_target_group_attachment" "PACAAD1_RAFV_Tg_Jenkins_att" {
#   target_group_arn = aws_lb_target_group.PACAAD1_RAFV_Jenkins_Tg.arn
#   target_id        = var.Jenkins_Host_id
#   port             = 8080
# }

# #Create a Load Balancer listener
# resource "aws_lb_listener" "PACAAD1_RAFV_nlb_listener" {
#   load_balancer_arn = aws_lb.PACAAD1_RAFV_Jenkins_lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.PACAAD1_RAFV_Jenkins_Tg.arn
#   }
# }


# #ADD an APPlication Load Balancer
# resource "aws_lb" "PACAAD1_RAFV_Docker_alb" {
#   name                       = var.docker_Lb_name
#   internal                   = false
#   load_balancer_type         = "application"
#   security_groups            = [var.JenDoc_SG_id]
#   subnets                    = [var.pub_sn1_id,var.pub_sn2_id]
#   enable_deletion_protection = false
# }
# #Add a load balancer Listener
# resource "aws_lb_listener" "PACAAD1_RAFV_alb_listener" {
#   load_balancer_arn = aws_lb.PACAAD1_RAFV_Docker_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.PACAAD1_RAFV_app_Tg.arn
#   }
# }
# # Create a Target Group for application Load Balancer
# resource "aws_lb_target_group" "PACAAD1_RAFV_app_Tg" {
#   name     = var.Docker_Lb_Tg_name
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id
#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 5
#     interval            = 30
#     timeout             = 5
#     path                = "/"
#   }
# }


# #Create Target group attachment for application lb
# resource "aws_lb_target_group_attachment" "PACAAD1_RAFV_Tg_att" {
#   target_group_arn = aws_lb_target_group.PACAAD1_RAFV_app_Tg.arn
#   target_id        = var.docker_target_id
#   port             = 8080
# }




# #####################################################################
# ###################   AUTO SCALING GROUP   ##########################
# #####################################################################


# #Docker-launch-configuration
# resource "aws_launch_configuration" "PACAAD1_RAFV_LaunchConfig" {
#   name_prefix                 = var.name_prefix_lc
#   image_id                    = var.ASG_image_id
#   instance_type               = var.ASG_instance_type
#   security_groups             = [var.ASG_vpc_security_group_ids]
#   associate_public_ip_address = false
#   key_name                    = var.keypair_name
# user_data                   = <<-EOF
# #!/bin/bash
# sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# sudo yum update -y
# sudo yum install docker-ce -y
# sudo yum install docker-ce-cli -y
# sudo yum install containerd.io -y
# sudo yum install python3 -y
# sudo yum install python3-pip -y
# sudo alternatives --set python /usr/bin/python3
# sudo pip3 install docker-py
# sudo systemctl start docker
# sudo systemctl enable docker
# echo "license_key: 18b989848e83ee998df70e98b20b815c02b0NRAL" | sudo tee -a /etc/newrelic-infra.yml
# sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
# sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
# sudo yum install newrelic-infra -y
# sudo hostnamectl set-hostname dockerHostASG
#   EOF

# }

# #Creating Autoscaling Group 
# resource "aws_autoscaling_group" "PACAAD1_RAFV_ASG" {
#   name                      = var.name_ASG
#   desired_capacity          = var.ASG_desired_capacity
#   max_size                  = var.ASG_max_size
#   min_size                  = var.ASG_min_size
#   health_check_grace_period = var.health_check_grace_period
#   health_check_type         = var.health_check_type
#   force_delete              = true
#   launch_configuration      = aws_launch_configuration.PACAAD1_RAFV_LaunchConfig.name
#   vpc_zone_identifier       = [var.vpc_zone_identifier]
#  # target_group_arns         = [var.target_group_arns]
#   tag {
#     key                 = "Name"
#     value               = var.ASG_tag_name
#     propagate_at_launch = true
#   }
# }

# #Creating Autoscaling Policy   
# resource "aws_autoscaling_policy" "PACAAD1_RAFV_ASG_Pol" {
#   name                   = var.ASG_policy_name
#   policy_type            = "TargetTrackingScaling"
#   adjustment_type        = "ChangeInCapacity"
#   autoscaling_group_name = aws_autoscaling_group.PACAAD1_RAFV_ASG.name
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = var.ASG_Pol_target_value
#   }
# }


# # #####################################################################
# # #########################   ROUTE 53   ##############################
# # #####################################################################

# # # Create Domain name using Route 53
# # resource "aws_route53_zone" "PACAAD1_RAFV_zone" {
# #   name          = var.Domain_name
# #   force_destroy = true
# # }
# # resource "aws_route53_record" "PACADEU1_www" {
# #   zone_id = aws_route53_zone.PACAAD1_RAFV_zone.zone_id
# #   name    = var.Domain_name

# #     type    = "A"
# #      alias {
# #       name                   = var.target_dns_name
# #       zone_id                = var.target_zone_id
# #       evaluate_target_health = var.evaluate_target_health
# #     }
# # }