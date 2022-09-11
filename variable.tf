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

#variable "all_cidr" {
#  default     = "0.0.0.0/0"
#  description = "PACAAD1_RAFV_VPC"
# }

#variable "vpc_id" {
#Change to next default when working with modules
#default = "vpc-0bc42661769aee87c"
# }



#####################################################################
###############   Bastion Host MODULE    ############################
#####################################################################

variable "Bastion_rhel_ami" {
  default     = "ami-0f0f1c02e5e4d9d9f"
  description = "RHEL instance ami"
}
variable "Bastion_instance_type" {
  default = "t2.micro"
}
variable "Bastion_vpc_security_group_ids" {
  #default = "BasAns_RAFV_SG"
  #Change to next default when working with modules
  default = "sg-0889e81bd04dd0734"
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
  default = "PACAAD1_RAFV_Bastion_Host"
}

variable "Bastion_Host_id" {
  default = "$data.aws_instance.PACAAD1_RAFV_Bastion_Host.id"
}

variable "Bastion_associate_public_ip_address" {
  type    = bool
  default = true
}



#####################################################################
###############   JENKINS MODULE    #################################
#####################################################################


variable "Jenkins_rhel_ami" {
  default = "ami-0f0f1c02e5e4d9d9f"
}

variable "Jenkins_instance_type" {
  default = "t2.medium"
}

variable "Jenkins_vpc_security_group_ids" {
  #default = "JenDoc_RAFV_SG"
  #Change to next default when working with modules
  default = "sg-0c2d16e977a18147a"
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
  default = "PACAAD1_RAFV_Jenkins_Host"
}

variable "Jenkins_Host_id" {
  default = "$data.aws_instance.PACAAD1_RAFV_Jenkins_Host.id"
}

variable "Jenkins_associate_public_ip_address" {
  type    = bool
  default = false
}



#####################################################################
###############   DOCKER MODULE    ##################################
#####################################################################

variable "Docker_rhel_ami" {
  default = "ami-0f0f1c02e5e4d9d9f"
}

variable "Docker_instance_type" {
  default = "t2.medium"
}

variable "Docker_Subnet_id" {
  default = "PACAAD1_RAFV_PRV_SN1"
  #Change to next default when working with modules
  #default = "subnet-0dfa85cd573b1898b"
}

variable "Docker_vpc_security_group_ids" {
  #default = "JenDoc_RAFV_SG"
  #Change to next default when working with modules
  default = "sg-0c2d16e977a18147a"
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

variable "Docker_Host_id" {
  default = "$data.aws_instance.PACAAD1_RAFV_Docker_Host.id"
}

variable "Docker_associate_public_ip_address" {
  type    = bool
  default = false
}


#####################################################################
###############   IAM + Ansible MODULE    ###########################
#####################################################################

variable "Ansible_rhel_ami" {
  default = "ami-0f0f1c02e5e4d9d9f"
}

variable "Ansible_instance_type" {
  default = "t2.medium"
}

variable "Ansible_vpc_security_group_ids" {
  default = "BasAns_RAFV_SG"
  #Change to next default when working with modules
  #default = "sg-0889e81bd04dd0734"
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
  default = "PACAAD1_RAFV_Ansible_Node"
}

variable "Ansible_Node_id" {
  default = "$data.aws_instance.PACAAD1_RAFV_Ansible_Node.id"
}

variable "Ansible_associate_public_ip_address" {
  type    = bool
  default = false
}


# #####################################################################
# ######################   LOAD BALANCER    ###########################
# #####################################################################

# # variable "instance_type" {
# #     default = "t2.medium"
# # }
# variable "LB_securitygroup_id" {
#       default = "$data.aws_security_group.JenDoc_RAFV_SG.id"
# #    type = string
# #    default="sg-036254702898cb50c"
# }
# # variable "subnet_id1" {
# #   type        = string
# #   default     = "subnet-76a8163a"
# #   description = "Subnet ID"
# # }
# #  variable "subnet_id2" {
# #   type        = string
# #   default     = "subnet-76a8163b"
# #   description = "Subnet ID"
# # }
# # variable "instance_id" {
# #     default = "i-0fc478dcb9081c543" 
# # }
# # variable "docker-host-ami" {
# #     default = "docker-host-ami"
# # }
# # variable "docker-asg-lc" {
# #     default = "docker-asg-lc"
# # }
# # variable "image_id" {
# #     default = "i-0fc478dcb9081c123"
# # }

# variable "Jenkins_Lb_name" {
#     default = "PACAAD1_RAFV_Jenkins_lb"
# }
# variable "Jenkins_Lb_Tg_name" {
#     default = "PACAAD1_RAFV_Jenkins_LbTg"
# }

# variable "docker_Lb_name" {
#     default = "PACAAD1_RAFV_Docker_alb"
# }
# variable "Docker_Lb_Tg_name" {
#     default = "PACAAD1_RAFV_Docker_LbTg"
# }

# # variable "vpc_id" {
# # default = "vpc-0e956f11ebd3cd342"
# # }
# # variable "docker_target_id" {
# #     default = "i-0fc478dcb9081c456"
# # }
# # variable "jenkins_server_id" {
# #     default = "i-06c72421746eb9205"
# # }



# #####################################################################
# ###################   AUTO SCALING GROUP   ##########################
# #####################################################################

# variable "ASG_instance_type" {
#     default = "t2.medium"
# }
# variable "name_prefix_lc" {
#   default = "PACAAD1_RAFV_LaunchConfig"
# }
# variable "name_ASG" {
#   default = "PACAAD1_RAFV_ASG"
# }
# variable "ASG_vpc_security_group_ids" {
#    default = "$data.aws_security_group.JenDoc_RAFV_SG.id"
#   #  type = string
#   #  default="sg-036254702898cb50c"
# }
# variable "ASG_tag_name" {
#    type = string
#    default="PACAAD1_RAFV_ASG"
# }
# variable "ASG_policy_name" {
#    type = string
#    default="PACAAD1_RAFV_ASG_Pol"
# }
# variable "subnet_id" {
#   type        = string
#   default     = "subnet-76a8163a"
#   description = "Subnet ID"
# }
# # variable "keypair_name" {
# #   default     = "PACAAD1_RAFV"
# #   description = "keypair name"
# # }
# variable "Docker_Host_id" {
#     default = "i-0fc478dcb9081c543" 
# }
# variable "docker-asg-lc" {
#     default = "docker-asg-lc"
# }
# variable "ASG_image_id" {
#     default = "ami-0f0f1c02e5e4d9d9f"
#     # default = "i-0fc478dcb9081c123"
# }
# variable "Docker-ASG-Name" {
#     default = "Docker-ASG"
# }
# variable "ASG_min_size" {
#     default = 2
# }
# variable "ASG_max_size" {
#     default = 5
# }
# variable "ASG_desired_capacity" {
#     default = 3
# }
# variable "health_check_grace_period" {
#     default = 300 
# }
# variable "target_group_arns" {
#  # default = "arn:aws:elasticloadbalancing:eu-west-1:627874023416:targetgroup/pacad-tg/ee734da43071bfd1"
# default = "arn:aws:elasticloadbalancing:eu-west-1"
# }
# variable "health_check_type" {
#     default = "EC2"
# }
# variable "vpc_zone_identifier" {
#   default = "$data.aws_subnet.PACAAD1_RAFV_PRV_SN1.id"
#     # type        = string
#     # default     = "subnet-76a8123a"
#     # description = "Subnet ID" 
# }
# # variable "vpc_id" {
# # default = "vpc-0e956f11ebd3cd342"
# # }
# variable "ASG_Pol_target_value" {
#   default = "75"
# }


# #####################################################################
# #########################   ROUTE 53   ##############################
# #####################################################################

# variable "Domain_name" {
#   default = "alexdevs.link"
# }
# variable "target_dns_name" {
#   type        = string
#   default = "2020430182.us-east-1.elb.amazonaws.com"
#   description = "DNS name of ELB"
# }
# variable "target_zone_id" {
#   type        = string
#   default = "0880e05c-8a25-4816-bddb-da236478dad9"
#   description = "ID of ELB"
# }
# variable "evaluate_target_health" {
#   type        = bool
#   default     = false
#   description = "Set to true if you want Route 53 to determine whether to respond to DNS queries"
# }