output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Public IP"
  value       = aws_instance.web_server.public_ip
}

output "private_ip" {
  description = "Private IP"
  value       = aws_instance.web_server.private_ip
}

output "public_dns" {
  description = "Public DNS"
  value       = aws_instance.web_server.public_dns
}

##############################################
# User Data
##############################################

output "user_data_base64" {

  description = "Base64 encoded User Data"

  value = aws_instance.web_server.user_data_base64

}