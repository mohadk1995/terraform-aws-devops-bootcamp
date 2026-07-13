output "instance_id" {

  value = aws_instance.web_server.id

}

output "public_ip" {

  value = aws_instance.web_server.public_ip

}

output "private_ip" {

  value = aws_instance.web_server.private_ip

}

output "public_dns" {

  value = aws_instance.web_server.public_dns

}

output "website_url" {

  value = "http://${aws_instance.web_server.public_ip}"

}

output "ssh_command" {

  value = "ssh -i terraform-generated-key.pem ec2-user@${aws_instance.web_server.public_ip}"

}

output "private_key" {

  value = tls_private_key.ec2_key.private_key_pem

  sensitive = true

}