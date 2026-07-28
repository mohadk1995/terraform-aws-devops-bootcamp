variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair Name"
  type        = string
}


variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

#############################################################
# IAM Instance Profile
#
# Name of the Instance Profile to attach to the EC2 instance.
#
# This enables the EC2 instance to obtain temporary AWS
# credentials automatically.
#############################################################

variable "instance_profile_name" {

  description = "IAM Instance Profile attached to EC2"

  type = string

}