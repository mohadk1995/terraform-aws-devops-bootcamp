#############################################################
# Bucket Name
#############################################################

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

#############################################################
# Environment
#############################################################

variable "environment" {
  description = "Deployment Environment"
  type        = string
}