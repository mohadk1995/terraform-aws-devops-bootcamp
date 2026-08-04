#############################################################
# S3 Bucket Name
#############################################################

locals {

  s3_bucket_name = "terraform-db-comparison-${data.aws_caller_identity.current.account_id}"

}