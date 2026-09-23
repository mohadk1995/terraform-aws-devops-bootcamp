# ==========================================
# DATA SOURCE
# ==========================================
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${lower(var.environment)}-vpc"
    Environment = var.environment
    Project     = "Terraform Bootcamp"
    ManagedBy   = "Terraform"
  }
}

#############################################################
# Public Subnet 1
#############################################################

resource "aws_subnet" "public_1" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${lower(var.environment)}-public-subnet-1"
    Environment = var.environment
  }
}

#############################################################
# Public Subnet 2
#############################################################

resource "aws_subnet" "public_2" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${lower(var.environment)}-public-subnet-2"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${lower(var.environment)}-igw"
  }
}
resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }

  tags = {
    Name = "${lower(var.environment)}-public-route-table"
  }
}

#############################################################
# Route Table Association - Public Subnet 1
#############################################################

resource "aws_route_table_association" "public_assoc_1" {

  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

#############################################################
# Route Table Association - Public Subnet 2
#############################################################

resource "aws_route_table_association" "public_assoc_2" {

  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}