variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "instance_name" {
  description = "EC2 Name"
  type        = string
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "key_name" {
  description = "AWS Key Pair Name"
  type        = string
}

variable "private_key_filename" {
  description = "Private key filename"
  type        = string
}