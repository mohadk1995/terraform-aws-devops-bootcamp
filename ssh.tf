module "ssh" {
  source = "./modules/ssh"

  key_name             = "terraform-generated-key"
  private_key_filename = "terraform-generated-key.pem"
}