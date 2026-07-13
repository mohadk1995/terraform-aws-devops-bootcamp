resource "local_file" "private_key" {

  filename = "terraform-generated-key.pem"

  content = tls_private_key.ec2_key.private_key_pem

  file_permission = "0400"

}