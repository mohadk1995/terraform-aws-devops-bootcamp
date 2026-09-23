#############################################################
# Auto Scaling Policy Variables
#############################################################

variable "asg_name" {

  description = "Name of the Auto Scaling Group to attach the scaling policy to"

  type = string

}