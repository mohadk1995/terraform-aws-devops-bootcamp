output "instance_id" {
  value       = aws_instance.web_server.id
  description = "The ID of the EC2 instance"
}

output "public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "The public IP address of the web server for user access"
}

output "private_ip" {
  value       = aws_instance.web_server.private_ip
  description = "The internal private IP of the instance"
}

output "private_key" {
  value     = tls_private_key.ec2_key.private_key_pem
  sensitive = true
}