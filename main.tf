# ==========================================
# 1. DATA SOURCES
# ==========================================
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ==========================================
# 2. DEPENDENCIES
# ==========================================
module "security_group" {
  source = "./modules/security-group"

  vpc_id              = module.network.vpc_id
  security_group_name = var.security_group_name
}

# ==========================================
# 3. MAIN RESOURCE
# ==========================================
module "ec2" {
  source = "./modules/ec2"

  ami_id            = data.aws_ami.amazon_linux_2023.id
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_1_id
  security_group_id = module.security_group.security_group_id
  key_name          = module.ssh.key_name

  #user_data         = file("${path.module}/scripts/install_nginx.sh")



  instance_name = local.instance_name
  #############################################################
  # Connect IAM Module to EC2 Module
  #
  # The root module wires modules together.
  #############################################################

  instance_profile_name = module.iam.instance_profile_name
}

############################################################
# Launch Template Module
############################################################

module "launch_template" {

  source = "./modules/launch-template"

  ##############################################
  # Launch Template
  ##############################################

  launch_template_name = local.launch_template_name

  ##############################################
  # EC2 Configuration
  ##############################################

  ami_id        = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  ##############################################
  # Security Group
  ##############################################

  security_group_id = module.security_group.security_group_id

  ##############################################
  # SSH
  ##############################################

  key_name = module.ssh.key_name

  ##############################################
  # IAM
  ##############################################

  instance_profile_name = module.iam.instance_profile_name

  ##############################################
  # User Data
  ##############################################

  user_data = filebase64("${path.root}/scripts/install_nginx.sh")

  ##############################################
  # Tags
  ##############################################

  environment = "Development"

}

# ==========================================
# 4. Call EIP in the root module
# ==========================================

module "eip" {
  source = "./modules/eip"

  instance_id = module.ec2.instance_id
}

#############################################################
# IAM Module
#
# The root module supplies resource names.
#
# This keeps the child module generic and reusable.
#############################################################

module "iam" {

  source = "./modules/iam"

  ###########################################################
  # IAM Role Name
  ###########################################################

  role_name = local.iam_role_name

  ###########################################################
  # IAM Instance Profile Name
  ###########################################################

  instance_profile_name = local.instance_profile_name

}

#############################################################
# CloudWatch Module
#
# Creates AWS CloudWatch resources used by
# the CloudWatch Agent.
#############################################################

module "cloudwatch" {

  source = "./modules/cloudwatch"

  ###########################################################
  # Log Group Configuration
  ###########################################################

  log_group_name = "/aws/ec2/devops-bootcamp"

  retention_in_days = 30

}

#############################################
# CloudWatch Alarm - CPU Utilization
#############################################

module "cpu_alarm" {

  source = "./modules/cloudwatch-alarm"

  ###########################################
  # Alarm Details
  ###########################################

  alarm_name        = local.cpu_alarm_name
  alarm_description = "Triggers when EC2 CPU utilization exceeds 80%"

  ###########################################
  # Metric Configuration
  ###########################################

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"
  period    = 300

  ###########################################
  # Alarm Behaviour
  ###########################################

  comparison_operator = "GreaterThanThreshold"

  threshold          = 80
  evaluation_periods = 2

  ###########################################
  # Target Resource
  ###########################################

  dimensions = {
    InstanceId = module.ec2.instance_id
  }

  ###########################################
  # Missing Data Behaviour
  ###########################################

  treat_missing_data = "missing"

}

#############################################
# CloudWatch Dashboard
#############################################

module "cloudwatch_dashboard" {

  source = "./modules/cloudwatch-dashboard"

  ###########################################
  # Dashboard Configuration
  ###########################################

  dashboard_name = local.dashboard_name

  ###########################################
  # EC2 Instance
  ###########################################

  instance_id = module.ec2.instance_id

  ###########################################
  # AWS Region
  ###########################################

  aws_region = var.aws_region

  ###########################################
  # Alarm
  ###########################################

  cpu_alarm_name = module.cpu_alarm.alarm_name

}

############################################################
# Auto Scaling Group
############################################################

module "autoscaling_group" {

  source = "./modules/autoscaling-group"

  ##############################################
  # Auto Scaling Group
  ##############################################

  asg_name = local.autoscaling_group

  ##############################################
  # Launch Template
  ##############################################

  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.latest_version

  ##############################################
  # Networking
  ##############################################

  subnet_ids = module.network.public_subnet_ids
  target_group_arns = [
    module.alb.target_group_arn
  ]

  ##############################################
  # Capacity
  ##############################################

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  ##############################################
  # Tags
  ##############################################

  environment = var.environment

}

#############################################################
# Application Load Balancer
#############################################################

module "alb" {

  source = "./modules/alb"

  ###########################################################
  # Name
  ###########################################################

  alb_name          = local.alb_name
  target_group_name = local.target_group_name
  vpc_id            = module.network.vpc_id


  ###########################################################
  # Networking
  ###########################################################

  subnet_ids = module.network.public_subnet_ids

  security_group_ids = [
    module.security_group.security_group_id
  ]

  ###########################################################
  # Environment
  ###########################################################

  environment = var.environment

}

#############################################################
# Target Group
#############################################################

module "target_group" {

  source = "./modules/target-group"

  ###########################################################
  # Name
  ###########################################################

  target_group_name = local.target_group_name

  ###########################################################
  # Networking
  ###########################################################

  vpc_id = module.network.vpc_id

  ###########################################################
  # Environment
  ###########################################################

  environment = var.environment

}

#############################################################
# Auto Scaling - Scale Out Policy
#############################################################

module "autoscaling_policy" {

  source = "./modules/autoscaling-policy"

  asg_name = local.autoscaling_group

}

#############################################################
# Auto Scaling - Scale Out Alarm
#############################################################

module "scale_out_alarm" {

  source = "./modules/cloudwatch-alarm"

  alarm_name = "${local.autoscaling_group}-scale-out"

  alarm_description = "Triggers scale-out when average CPU utilization is greater than or equal to 70%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"
  period    = 300

  comparison_operator = "GreaterThanOrEqualToThreshold"

  threshold = 70

  evaluation_periods = 2

  dimensions = {
    AutoScalingGroupName = local.autoscaling_group
  }

  treat_missing_data = "missing"

  alarm_actions = [
    module.autoscaling_policy.scale_out_policy_arn
  ]

}

#############################################################
# Auto Scaling - Scale In Alarm
#############################################################

module "scale_in_alarm" {

  source = "./modules/cloudwatch-alarm"

  alarm_name = "${local.autoscaling_group}-scale-in"

  alarm_description = "Triggers scale-in when average CPU utilization is less than or equal to 30%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"
  period    = 300

  comparison_operator = "LessThanOrEqualToThreshold"

  threshold = 30

  evaluation_periods = 2

  dimensions = {
    AutoScalingGroupName = local.autoscaling_group
  }

  treat_missing_data = "missing"

  alarm_actions = [
    module.autoscaling_policy.scale_in_policy_arn
  ]

}

