variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_name" {
  description = "Terraform Remote State Bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Terraform Lock Table"
  type        = string
}