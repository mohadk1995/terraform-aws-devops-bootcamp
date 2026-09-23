#############################################################
# Target Group ARN
#############################################################

output "target_group_arn" {

  description = "Target Group ARN"

  value = aws_lb_target_group.this.arn

}

#############################################################
# Target Group Name
#############################################################

output "target_group_name" {

  description = "Target Group Name"

  value = aws_lb_target_group.this.name

}