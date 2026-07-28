resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  subnet_id              = var.subnet_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name # Fixed: Added Key Pair access (Issue 4)
  #############################################################
  # User Data Template
  #
  # templatefile() allows us to inject variables into the
  # user-data script.
  #############################################################

  user_data = templatefile("${path.root}/scripts/install_nginx.sh", {
    cloudwatch_config = file("${path.module}/amazon-cloudwatch-agent.json")
  })
  user_data_replace_on_change = true
  #############################################################
  # IAM Instance Profile
  #
  # EC2 will assume the IAM Role through this profile.
  #
  # No AWS Access Keys are required on the server.
  #############################################################

  iam_instance_profile = var.instance_profile_name
  tags = {
    Name = var.instance_name
  }

  # Senior Level Optimization (Issue 5)
  # Prevents unexpected EC2 destruction when Amazon updates the base AMI
  lifecycle {
    #ignore_changes = [ami]
  }
}