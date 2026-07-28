##############################################
# Launch Template
##############################################

resource "aws_launch_template" "this" {

  ###########################################
  # Basic Configuration
  ###########################################

  name          = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  ###########################################
  # Networking
  ###########################################

  vpc_security_group_ids = [
    var.security_group_id
  ]

  ###########################################
  # SSH Key
  ###########################################

  key_name = var.key_name

  ###########################################
  # IAM Role
  ###########################################

  iam_instance_profile {
    name = var.instance_profile_name
  }

  ###########################################
  # User Data
  ###########################################

  user_data = var.user_data

  ###########################################
  # Tags
  ###########################################

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name        = "Terraform-ASG-Instance"
      Environment = var.environment
    }
  }

  ###########################################
  # Update Behaviour
  ###########################################

  update_default_version = true
}