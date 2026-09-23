#############################################################
# ALB Name
#############################################################

variable "alb_name" {
  description = "Application Load Balancer Name"
  type        = string
}

#############################################################
# Subnets
#############################################################

variable "subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

#############################################################
# Security Groups
#############################################################

variable "security_group_ids" {
  description = "Security Groups attached to the ALB"
  type        = list(string)
}

#############################################################
# Environment
#############################################################

variable "environment" {
  description = "Deployment Environment"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "target_group_name" {
  type = string
}