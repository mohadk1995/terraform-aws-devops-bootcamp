#############################################################
# Environment Prefix
#############################################################

locals {

  env_prefix = lower(var.environment)

  ###########################################################
  # Common Names
  ###########################################################

  instance_name = "${local.env_prefix}-web-server"

  launch_template_name = "${local.env_prefix}-launch-template"

  autoscaling_group = "${local.env_prefix}-asg"

  dashboard_name = "${local.env_prefix}-dashboard"

  cpu_alarm_name = "${local.env_prefix}-high-cpu"

  iam_role_name = "${local.env_prefix}-ec2-role"

  instance_profile_name = "${local.env_prefix}-instance-profile"

  alb_name          = "${local.env_prefix}-alb"
  target_group_name = "${local.env_prefix}-tg"
  listener_name     = "${local.env_prefix}-listener"


}

