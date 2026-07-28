#############################################################
# Output the Instance Profile Name
#
# This will be passed to the EC2 module.
#############################################################

output "instance_profile_name" {

  description = "IAM Instance Profile Name"

  value = aws_iam_instance_profile.ec2_profile.name

}

#############################################################
# Output the IAM Role Name
#
# Useful for debugging and future references.
#############################################################

output "role_name" {

  description = "IAM Role Name"

  value = aws_iam_role.ec2_role.name

}