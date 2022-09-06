#####################################################################
###############   VPC MODULE    #####################################
#####################################################################

variable "VPC_cidr" {
  default = "10.0.0.0/16"
}

variable "VPC_name" {
  default = "PACAAD1_RAFV_VPC"
}
variable "PUB_SN1_cidr" {
  default = "10.0.1.0/24"
}

variable "PUB_SN2_cidr" {
  default = "10.0.2.0/24"
}

variable "PRV_SN1_cidr" {
  default = "10.0.3.0/24"
}

variable "PRV_SN2_cidr" {
  default = "10.0.4.0/24"
}
variable "PUB_SN1_name" {
  default = "PACAAD1_RAFV_PUB_SN1"
}
variable "PUB_SN2_name" {
  default = "PACAAD1_RAFV_PUB_SN2"
}
variable "PRV_SN1_name" {
  default = "PACAAD1_RAFV_PRV_SN1"
}
variable "PRV_SN2_name" {
  default = "PACAAD1_RAFV_PRV_SN2"
}
variable "all_cidr" {
  default = "0.0.0.0/0"
}
variable "IGW_name" {
  default = "PACAAD1_RAFV_IGW"
}
variable "EIP_name" {
  default = "PACAAD1_RAFV_EIP"
}
variable "NAT_name" {
  default = "PACAAD1_RAFV_NAT_GW"
}
variable "PUB_RT_name" {
  default = "PACAAD1_RAFV_PUB_RT"
}
variable "PRV_RT_name" {
  default = "PACAAD1_RAFV_PRV_RT"
}
variable "az_A" {
  default = "eu-west-1a"
}
variable "az_B" {
  default = "eu-west-1b"
}

#####################################################################
###############   Keypair MODULE   ##################################
#####################################################################

variable "keypair_name" {
  default     = "PACAAD1_RAFV"
  description = "keypair name"
}
variable "path-to-publickey" {
  default     = "~/Keypairs/AutodiscoveryPA.pub"
  description = "this is path to the keypair in our local machine"
}



#####################################################################
###############   SecurityGroups MODULE    ##########################
#####################################################################


# Security_Group variables 
variable "JenDoc_RAFV_SG_name" {
    default = "JenDoc_RAFV_SG"
}
variable "BasAns_RAFV_SG_name" {
    default = "BasAns_RAFV_SG"
}
variable "DB_RAFV_SG_name" {
    default = "DB_RAFV_SG"
}
variable "Custom_http" {
    default = 8080
}
variable "ssh_port" {
    default = 22
}
variable "http_port" {
    default = 80
}

variable "mysql_port" {
    default = 3306
}
variable "vpc_cidr" {
    default     = "10.0.0.0/16"
    description = "PACAAD1_RAFV_VPC"
}

  variable "all_cidr" {
    default     = "0.0.0.0/0"
    description = "PACAAD1_RAFV_VPC"
}
variable "vpc_id" {
    default = "PACAAD1_RAFV_VPC"
    #Change to next default when working with modules
    #default = "vpc-0166902839c6ffb8c"
}



#####################################################################
###############   Bastion Host MODULE    ############################
#####################################################################

variable "Bastion_rhel_ami" {
    default = "ami-0f0f1c02e5e4d9d9f"
    description = "RHEL instance ami"
}
variable "Bastion_instance_type" {
    default = "t2.micro"
}
variable "Bastion_vpc_security_group_ids" {
    default = "BasAns_RAFV_SG"
    #Change to next default when working with modules
    #default = "sg-0102fd013346e351e"
}
variable "Bastion_subnet_id" {
    default = "PACAAD1_RAFV_PUB_SN1"
    #Change to next default when working with modules
    #default = "subnet-76a8163a"
}

# variable "keypair_name" {
#     default = "PACAAD1_RAFV"
# }
# variable "path-to-publickey" {
#   default     = "~/Keypairs/AutodiscoveryPA.pub"
#   description = "this is path to the keypair in our local machine"
# }

variable "PACAAD1_RAFV_Bastion_Host_Name" {
  default   =  "PACAAD1_RAFV_Bastion_Host"
}

variable "Bastion_associate_public_ip_address" {
  type   = bool
  default = true
}



#####################################################################
###############   JENKINS MODULE    #################################
#####################################################################


variable "Jenkins_rhel_ami" {
  default = "ami-035c5dc086849b5de"
}

variable "Jenkins_instance_type" {
  default = "t2.medium"
}

variable "Jenkins_vpc_security_group_ids" {
    default = "JenDoc_RAFV_SG"
    #Change to next default when working with modules
    #default = "sg-067477a8dc7c0ecff"
}

variable "Jenkins_Subnet_id" {
    default = "PACAAD1_RAFV_PRV_SN2"
    #Change to next default when working with modules
    #default = "subnet-0dfa85cd573b1898b"
}

# variable "keypair_name" {
#     default = "PACAAD1_RAFV"
# }
# variable "path-to-publickey" {
#   default     = "~/Keypairs/AutodiscoveryPA.pub"
#   description = "this is path to the keypair in our local machine"
# }

variable "PACAAD1_RAFV_Jenkins_Host_Name" {
  default   =  "PACAAD1_RAFV_Jenkins_Host"
}

variable "Jenkins_associate_public_ip_address" {
  type   = bool
  default = false
}



#####################################################################
###############   DOCKER MODULE    ##################################
#####################################################################

variable "Docker_rhel_ami" {
    default = "ami-035c5dc086849b5de"
}

variable "Docker_instance_type" {
    default = "t2.medium"
}

variable "Docker_Subnet_id" {
    default = "PACAAD1_RAFV_PRV_SN1,PACAAD1_RAFV_PRV_SN2"
    #Change to next default when working with modules
    #default = "subnet-0dfa85cd573b1898b"
}

variable "Docker_vpc_security_group_ids" {
    default = "JenDoc_RAFV_SG"
    #Change to next default when working with modules
    #default = "sg-067477a8dc7c0ecff"
}

# variable "keypair_name" {
#     default = "PACAAD1_RAFV"
# }
# variable "path-to-publickey" {
#   default     = "~/Keypairs/AutodiscoveryPA.pub"
#   description = "this is path to the keypair in our local machine"
# }

variable "PACAAD1_RAFV_Docker_Host_Name" {
    default = "PACAAD1_RAFV_Docker_Host"
}

variable "Docker_associate_public_ip_address" {
  type   = bool
  default = false
}


#####################################################################
###############   IAM + Ansible MODULE    ###########################
#####################################################################

variable "Ansible_rhel_ami" {
    default = "ami-035c5dc086849b5de"
}

variable "Ansible_instance_type" {
    default = "t2.medium"
}

variable "Ansible_vpc_security_group_ids" {
  default = "BasAns_RAFV_SG"
    #Change to next default when working with modules
    #default = "sg-008291e750ad9bea8"
}

variable "Ansible_Subnet_id" {
  default = "PACAAD1_RAFV_PRV_SN1"
    #Change to next default when working with modules
    #default = "subnet-0dfa85cd573b1898b"
}

# variable "keypair_name" {
#     default = "PACAAD1_RAFV"
# }
# variable "path-to-publickey" {
#   default     = "~/Keypairs/AutodiscoveryPA.pub"
#   description = "this is path to the keypair in our local machine"
# }
   
variable "PACAAD1_RAFV_Ansible_Node_Name" {
  default   =  "PACAAD1_RAFV_Ansible_Node"
}

variable "Jenkins_associate_public_ip_address" {
  type   = bool
  default = false
}