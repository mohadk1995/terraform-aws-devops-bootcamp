#############################################################
# Target Group Name
#############################################################

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
}

#############################################################
# VPC
#############################################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

#############################################################
# Environment
#############################################################

variable "environment" {
  description = "Deployment Environment"
  type        = string
}