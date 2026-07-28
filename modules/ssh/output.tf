output "key_name" {
  description = "AWS Key Pair Name"
  value       = aws_key_pair.generated_key.key_name
}

output "private_key" {
  description = "Generated private key"
  value       = tls_private_key.ec2_key.private_key_pem
  sensitive   = true
}

output "public_key" {
  description = "Generated public key"
  value       = tls_private_key.ec2_key.public_key_openssh
}