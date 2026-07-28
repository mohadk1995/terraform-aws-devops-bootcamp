## create the S3 bucket.
resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name

  lifecycle {

    prevent_destroy = true

  }

  tags = {

    Name        = "Terraform State Bucket"
    Environment = "Bootstrap"

  }

}

## Create DynamoDB Table
resource "aws_dynamodb_table" "terraform_lock" {

  name = var.dynamodb_table_name

  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {

    name = "LockID"

    type = "S"

  }

  tags = {

    Name = "Terraform Lock Table"

  }

}

## s3-versioning.tf
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

resource "aws_s3_bucket_public_access_block" "terraform_state_public_access" {

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}

resource "aws_s3_bucket_ownership_controls" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    object_ownership = "BucketOwnerEnforced"

  }

}
