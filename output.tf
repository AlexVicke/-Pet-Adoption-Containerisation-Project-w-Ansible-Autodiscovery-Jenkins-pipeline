#####################################################################
###############   VPC MODULE    #####################################
#####################################################################


output "vpc_id" {
  value = aws_vpc.PACAAD1_RAFV_VPC.id
}
output "pubic_sn1_id" {
  value = aws_subnet.PACAAD1_RAFV_PUB_SN1.id
}
output "public_sn2_id" {
  value = aws_subnet.PACAAD1_RAFV_PUB_SN2.id
}
output "private_sn1_id" {
  value = aws_subnet.PACAAD1_RAFV_PRV_SN1.id
}
output "private_sn2_id" {
  value = aws_subnet.PACAAD1_RAFV_PRV_SN2.id
}



#####################################################################
###############   Keypair MODULE   ##################################
#####################################################################

output "keypair_name" {
  value = aws_key_pair.PACAAD1_RAFV.key_name
}
output "keypair_id" {
  value = aws_key_pair.PACAAD1_RAFV.id
}




#####################################################################
###############   SecurityGroups MODULE    ##########################
#####################################################################

output "JenDoc_RAFV_SG_id" {
  value = aws_security_group.JenDoc_RAFV_SG.id
}
output "BasAns_RAFV_SG_id" {
  value = aws_security_group.BasAns_RAFV_SG.id
}
output "DB_RAFV_SG_id" {
  value = aws_security_group.DB_RAFV_SG.id
}



#####################################################################
###############   Bastion Host MODULE    ############################
#####################################################################

output "Bastion_host_id" {
  value = aws_instance.PACAAD1_RAFV_Bastion_Host.id
}

output "Bastion_public_ip" {
  value = aws_instance.PACAAD1_RAFV_Bastion_Host.public_ip
}



#####################################################################
###############   JENKINS MODULE    #################################
#####################################################################

output "Jenkins_Host_id" {
  value = aws_instance.PACAAD1_RAFV_Jenkins_Host.id
}

output "Jenkins_private_ip" {
  value = aws_instance.PACAAD1_RAFV_Jenkins_Host.private_ip
}



#####################################################################
###############   DOCKER MODULE    ##################################
#####################################################################

output "Docker_Host_id" {
  value = aws_instance.PACAAD1_RAFV_Docker_Host.id
}

output "Docker_private_ip" {
  value = aws_instance.PACAAD1_RAFV_Docker_Host.private_ip
}

output "Docker_ami" {
  value = aws_instance.PACAAD1_RAFV_Docker_Host.ami
}


#####################################################################
###############   IAM + Ansible MODULE    ###########################
#####################################################################

output "IAM_role_id" {
  value = aws_iam_role.PACAAD1_RAFV_Ansible_IAM_role.id
}

output "IAM_role_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.PACAAD1_Ansible_IAM_role_policy_att.policy_arn
}

output "IAM_Instance_Profile_id" {
  value = aws_iam_instance_profile.PACAAD1_RAFV_Ansible_IAM_instance_profile.id
}

#Correct output sintaxys as showing error**********
# output "IAM_policy_document_AssumeRole_id" {
#   value = aws_iam_policy_document.PACAAD1_RAFV_Ansible_IAM_role_policy.policy_arn
# }

output "IAM_role_policy_id" {
  value = aws_iam_policy.PACAAD1_RAFV_Ansible_IAM_policy.id
}

output "Ansible_node_id" {
  value = aws_instance.PACAAD1_RAFV_Ansible_Node.id
}

output "Ansible_private_ip" {
  value = aws_instance.PACAAD1_RAFV_Ansible_Node.private_ip
}