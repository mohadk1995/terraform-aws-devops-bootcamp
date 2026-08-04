#############################################################
# Bucket Name
#############################################################

output "bucket_name" {

  description = "S3 Bucket Name"

  value = aws_s3_bucket.this.bucket

}

#############################################################
# Bucket ARN
#############################################################

output "bucket_arn" {

  description = "Bucket ARN"

  value = aws_s3_bucket.this.arn

}