#############################################################
# AWS Caller Identity
#############################################################

data "aws_caller_identity" "current" {}
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
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security_group.security_group_id
  key_name          = module.ssh.key_name

  #user_data         = file("${path.module}/scripts/install_nginx.sh")



  instance_name = "devops-bootcamp-server"
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

  launch_template_name = "terraform-launch-template"

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

  user_data = module.ec2.user_data_base64

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

  role_name = "devops-bootcamp-ec2-role"

  ###########################################################
  # IAM Instance Profile Name
  ###########################################################

  instance_profile_name = "devops-bootcamp-instance-profile"
  s3_bucket_arn         = module.s3.bucket_arn


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

  alarm_name        = "HighCPUUtilization"
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

  dashboard_name = "Terraform-Bootcamp-Dashboard"

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

  asg_name = "terraform-asg"

  ##############################################
  # Launch Template
  ##############################################

  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.latest_version

  ##############################################
  # Networking
  ##############################################

  subnet_ids = [
    module.network.public_subnet_id
  ]

  ##############################################
  # Capacity
  ##############################################

  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  ##############################################
  # Tags
  ##############################################

  environment = "Development"

}

#############################################################
# S3 Bucket
#############################################################

module "s3" {

  source = "./modules/s3"

  bucket_name = local.s3_bucket_name

  environment = "Development"

}