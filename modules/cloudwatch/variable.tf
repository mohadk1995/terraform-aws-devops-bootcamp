#############################################################
# CloudWatch Log Group Name
#
# Example:
# /aws/ec2/devops-bootcamp
#############################################################

variable "log_group_name" {

  description = "CloudWatch Log Group Name"

  type = string

}

#############################################################
# Log Retention
#
# Number of days logs should be retained.
#
# Common values:
# 7
# 14
# 30
# 90
# 365
#############################################################

variable "retention_in_days" {

  description = "Retention period for CloudWatch Logs"

  type = number

  default = 30

}