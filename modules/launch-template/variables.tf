##############################################
# Launch Template Configuration
##############################################

variable "launch_template_name" {
  description = "Name of the Launch Template"
  type        = string
}

##############################################
# EC2 Configuration
##############################################

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

##############################################
# Networking
##############################################

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

##############################################
# SSH
##############################################

variable "key_name" {
  description = "SSH Key Pair Name"
  type        = string
}

##############################################
# IAM
##############################################

variable "instance_profile_name" {
  description = "IAM Instance Profile Name"
  type        = string
}

##############################################
# User Data
##############################################

variable "user_data" {
  description = "User data script"
  type        = string
}

##############################################
# Tags
##############################################

variable "environment" {
  description = "Environment Name"
  type        = string
}