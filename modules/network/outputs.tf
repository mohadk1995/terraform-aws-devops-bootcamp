#############################################################
# VPC
#############################################################

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

#############################################################
# Public Subnet 1
#############################################################

output "public_subnet_1_id" {
  description = "ID of Public Subnet 1"
  value       = aws_subnet.public_1.id
}

#############################################################
# Public Subnet 2
#############################################################

output "public_subnet_2_id" {
  description = "ID of Public Subnet 2"
  value       = aws_subnet.public_2.id
}

#############################################################
# Public Subnet List
#############################################################

output "public_subnet_ids" {
  description = "List of Public Subnet IDs"
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}