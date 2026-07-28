##############################################
# Auto Scaling Group Outputs
##############################################

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.this.name
}

output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.this.arn
}

output "desired_capacity" {
  description = "Desired Capacity"
  value       = aws_autoscaling_group.this.desired_capacity
}