#############################################################
# ALB ARN
#############################################################

output "alb_arn" {

  description = "Application Load Balancer ARN"

  value = aws_lb.this.arn

}

#############################################################
# DNS Name
#############################################################

output "alb_dns_name" {

  description = "Application Load Balancer DNS Name"

  value = aws_lb.this.dns_name

}

#############################################################
# Hosted Zone ID
#############################################################

output "alb_zone_id" {

  description = "Hosted Zone ID"

  value = aws_lb.this.zone_id

}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}