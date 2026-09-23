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

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired Capacity"
  type        = number
}

variable "min_size" {
  description = "Minimum Capacity"
  type        = number
}

variable "max_size" {
  description = "Maximum Capacity"
  type        = number
}

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  type        = string
}