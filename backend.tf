terraform {
  backend "s3" {
    bucket         = "terraform-state-mohammed-2026-ap-south-1"
    key            = "devops-bootcamp/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}