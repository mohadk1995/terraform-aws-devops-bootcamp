# ==========================================
# 1. DATA SOURCES
# ==========================================
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ==========================================
# 2. DEPENDENCIES
# ==========================================
resource "aws_security_group" "web_sg" {
  name        = var.security_group_name # Fixed: Fully dynamic variable (Issue 2)
  description = "Allow inbound traffic for web server (SSH, HTTP, HTTPS)"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Web Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Secure Web Traffic"
    from_port   = 443 # Fixed: Added secure web port (Issue 1)
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ==========================================
# 3. MAIN RESOURCE
# ==========================================
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.generated_key.key_name # Fixed: Added Key Pair access (Issue 4)

  tags = {
    Name = var.instance_name
  }

  # Senior Level Optimization (Issue 5)
  # Prevents unexpected EC2 destruction when Amazon updates the base AMI
  lifecycle {
    ignore_changes = [ami]
  }
}