##############################################
# Auto Scaling Group
##############################################

resource "aws_autoscaling_group" "this" {

  name = var.asg_name

  ###########################################
  # Capacity
  ###########################################

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  ###########################################
  # Networking
  ###########################################

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  ###########################################
  # Launch Template
  ###########################################

  launch_template {

    id      = var.launch_template_id
    version = var.launch_template_version

  }

  ###########################################
  # Health Check
  ###########################################

  health_check_type = "EC2"

  health_check_grace_period = 300

  ###########################################
  # Tags
  ###########################################

  tag {

    key                 = "Name"
    value               = "Terraform-ASG-Instance"
    propagate_at_launch = true

  }

  tag {

    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true

  }

}