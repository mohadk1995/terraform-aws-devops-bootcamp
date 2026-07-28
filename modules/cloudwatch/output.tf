#############################################################
# CloudWatch Log Group Name
#############################################################

output "log_group_name" {

  description = "CloudWatch Log Group Name"

  value = aws_cloudwatch_log_group.ec2_logs.name

}