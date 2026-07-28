#############################################################
# CloudWatch Log Group
#
# Purpose:
# Stores logs sent by the CloudWatch Agent.
#
# Examples:
# - System Logs
# - Nginx Logs
# - Application Logs
#
# Production Best Practice:
# Always configure a retention policy.
# Never leave logs with infinite retention unless required.
#############################################################

resource "aws_cloudwatch_log_group" "ec2_logs" {

  ###########################################################
  # Log Group Name
  ###########################################################

  name = var.log_group_name

  ###########################################################
  # Log Retention
  ###########################################################

  retention_in_days = var.retention_in_days

  ###########################################################
  # Resource Tags
  ###########################################################

  tags = {

    Name = "devops-bootcamp-cloudwatch"

    Environment = "Dev"

    ManagedBy = "Terraform"

  }

}

#############################################################
# REVISION NOTES
#
# CloudWatch Log Group
#
# Stores application and operating system logs.
#
# Examples:
#
# /var/log/messages
#
# /var/log/nginx/access.log
#
# /var/log/nginx/error.log
#
#############################################################