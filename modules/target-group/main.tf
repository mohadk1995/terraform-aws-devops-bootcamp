#############################################################
# Application Load Balancer Target Group
#############################################################

resource "aws_lb_target_group" "this" {

  name = var.target_group_name

  port = 80

  protocol = "HTTP"

  target_type = "instance"

  vpc_id = var.vpc_id

  ###########################################################
  # Health Check
  ###########################################################

  health_check {

    enabled = true

    protocol = "HTTP"

    path = "/"

    port = "traffic-port"

    healthy_threshold = 2

    unhealthy_threshold = 2

    timeout = 5

    interval = 30

    matcher = "200"

  }

  tags = {

    Name = var.target_group_name

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}