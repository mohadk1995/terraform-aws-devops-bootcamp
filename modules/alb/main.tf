#############################################################
# Application Load Balancer
#############################################################

resource "aws_lb" "this" {

  name = var.alb_name

  load_balancer_type = "application"

  internal = false

  subnets = var.subnet_ids

  security_groups = var.security_group_ids

  enable_deletion_protection = false

  tags = {

    Name        = var.alb_name
    Environment = var.environment
    ManagedBy   = "Terraform"

  }

}

#############################################################
# HTTP Listener
#############################################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = var.target_group_arn

  }

}