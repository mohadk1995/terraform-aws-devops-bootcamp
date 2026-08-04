#############################################################
# IAM Module Variables
#
# These variables make the module reusable.
#
# Instead of hardcoding resource names inside the module,
# the root module will pass them as inputs.
#############################################################

#############################################################
# IAM Role Name
#############################################################

variable "role_name" {

  description = "Name of the IAM Role"

  type = string

}

#############################################################
# Instance Profile Name
#############################################################

variable "instance_profile_name" {

  description = "Name of the IAM Instance Profile"

  type = string

}

#############################################################
# S3 Bucket ARN
#############################################################

variable "s3_bucket_arn" {

  description = "S3 Bucket ARN"

  type = string

}