output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "private_ip" {
  value = module.ec2.private_ip
}

output "public_dns" {
  value = module.ec2.public_dns
}

output "elastic_ip" {
  value = module.eip.public_ip
}

output "website_url" {
  value = "http://${module.eip.public_ip}"
}

output "ssh_command" {
  value = "ssh -i modules/ssh/terraform-generated-key.pem ec2-user@${module.eip.public_ip}"
}

#############################################
# CloudWatch Alarm Outputs
#############################################

output "cpu_alarm_name" {
  description = "CPU CloudWatch Alarm Name"
  value       = module.cpu_alarm.alarm_name
}

output "cpu_alarm_arn" {
  description = "CPU CloudWatch Alarm ARN"
  value       = module.cpu_alarm.alarm_arn
}

output "cpu_alarm_id" {
  description = "CPU CloudWatch Alarm ID"
  value       = module.cpu_alarm.alarm_id
}

#############################################
# Dashboard Outputs
#############################################

output "dashboard_name" {
  description = "CloudWatch Dashboard Name"
  value       = module.cloudwatch_dashboard.dashboard_name
}

output "dashboard_arn" {
  description = "CloudWatch Dashboard ARN"
  value       = module.cloudwatch_dashboard.dashboard_arn
}

############################################################
# Launch Template
############################################################

output "launch_template_id" {

  value = module.launch_template.launch_template_id

}

output "launch_template_name" {

  value = module.launch_template.launch_template_name

}

output "launch_template_latest_version" {

  value = module.launch_template.latest_version

}

############################################################
# Auto Scaling Group
############################################################

output "asg_name" {

  value = module.autoscaling_group.asg_name

}

output "asg_arn" {

  value = module.autoscaling_group.asg_arn

}