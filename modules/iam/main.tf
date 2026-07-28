###############################################
# IAM MODULE
#
# Purpose:
# Create an IAM Role for EC2 instances.
#
# This role allows the EC2 instance to securely
# access AWS services WITHOUT storing access keys.
#
# Best Practice:
# Never store AWS Access Keys inside an EC2 instance.
# Always use IAM Roles.
###############################################

###############################################
# IAM ROLE
###############################################

resource "aws_iam_role" "ec2_role" {

  # Name of the IAM Role that will appear in AWS Console
  name = var.role_name

  ##########################################################
  # Every IAM Role must have an Assume Role Policy.
  #
  # This policy answers the question:
  #
  # "Who is allowed to assume this role?"
  #
  # In our case:
  # EC2 Service (ec2.amazonaws.com)
  ##########################################################

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]
  })

  ###############################################
  # Common Tags
  ###############################################

  tags = {
    Name        = "devops-bootcamp-ec2-role"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

#############################################################
# Attach Amazon S3 Read Only Policy
#
# This is an AWS Managed Policy.
#
# It allows:
# - List Buckets
# - Read Objects
#
# It DOES NOT allow:
# - Upload Objects
# - Delete Objects
#############################################################

resource "aws_iam_role_policy_attachment" "s3_readonly" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}

#############################################################
# Attach CloudWatch Agent Policy
#
# Allows CloudWatch Agent running on EC2
# to send logs and metrics to CloudWatch.
#############################################################

resource "aws_iam_role_policy_attachment" "cloudwatch" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

#############################################################
# Attach Systems Manager Policy
#
# Enables:
# - Session Manager
# - Run Command
# - Patch Manager
#
# This means we can manage EC2 without SSH.
#############################################################

resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

#############################################################
# IAM Instance Profile
#
# IMPORTANT:
#
# EC2 cannot directly attach an IAM Role.
#
# EC2 attaches an Instance Profile.
#
# Instance Profile --> IAM Role
#############################################################

resource "aws_iam_instance_profile" "ec2_profile" {

  name = var.instance_profile_name

  role = aws_iam_role.ec2_role.name

}

#############################################################
# REVISION NOTES
#
# IAM Role
#     ↓
# Contains Permissions
#
# Instance Profile
#     ↓
# Bridge between IAM Role and EC2
#
# EC2
#
# Remember:
#
# EC2 never attaches directly to a Role.
#
# EC2 → Instance Profile → IAM Role
#############################################################
