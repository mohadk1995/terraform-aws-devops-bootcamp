##############################################
# Auto Scaling Group
##############################################

variable "asg_name" {
  description = "Auto Scaling Group Name"
  type        = string
}

##############################################
# Launch Template
##############################################

variable "launch_template_id" {
  description = "Launch Template ID"
  type        = string
}

variable "launch_template_version" {
  description = "Launch Template Version"
  type        = string
}

##############################################
# Networking
##############################################

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

##############################################
# Capacity
##############################################

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
}

##############################################
# Tags
##############################################

variable "environment" {
  description = "Environment"
  type        = string
}