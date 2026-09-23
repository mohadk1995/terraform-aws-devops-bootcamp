#############################################################
# Auto Scaling Scale-Out Policy
#############################################################

resource "aws_autoscaling_policy" "scale_out" {

  # Name of the scaling policy
  name = "${var.asg_name}-scale-out"

  # ASG that this policy controls
  autoscaling_group_name = var.asg_name

  # Change the desired capacity by the specified amount
  adjustment_type = "ChangeInCapacity"

  # Increase desired capacity by 1 instance
  scaling_adjustment = 1

  # Wait 300 seconds before another scaling action
  cooldown = 300

}

#############################################################
# Auto Scaling Scale-In Policy
#############################################################

resource "aws_autoscaling_policy" "scale_in" {

  # Name of the scaling policy
  name = "${var.asg_name}-scale-in"

  # ASG that this policy controls
  autoscaling_group_name = var.asg_name

  # Change the desired capacity by the specified amount
  adjustment_type = "ChangeInCapacity"

  # Decrease desired capacity by 1 instance
  scaling_adjustment = -1

  # Wait 300 seconds before another scaling action
  cooldown = 300

}