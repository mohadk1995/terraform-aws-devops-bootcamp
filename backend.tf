terraform {
  backend "s3" {
    bucket = "terraform-state-mohammed-2026-ap-south-1"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}