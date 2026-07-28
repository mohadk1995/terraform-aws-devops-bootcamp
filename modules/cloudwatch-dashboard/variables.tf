#############################################
# Dashboard Configuration
#############################################

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

#############################################
# EC2 Instance
#############################################

variable "instance_id" {
  description = "EC2 Instance ID to monitor"
  type        = string
}

#############################################
# AWS Region
#############################################

variable "aws_region" {
  description = "AWS region where the resources are deployed"
  type        = string
}

#############################################
# Alarm Names
#############################################

variable "cpu_alarm_name" {
  description = "CPU CloudWatch alarm name"
  type        = string
}