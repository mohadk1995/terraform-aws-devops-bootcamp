#############################################################
# Auto Scaling Policy Outputs
#############################################################

output "scale_out_policy_arn" {

  description = "ARN of the Auto Scaling scale-out policy"

  value = aws_autoscaling_policy.scale_out.arn

}

output "scale_in_policy_arn" {

  description = "ARN of the Auto Scaling scale-in policy"

  value = aws_autoscaling_policy.scale_in.arn

}