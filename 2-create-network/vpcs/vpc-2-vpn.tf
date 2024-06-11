# VPC
resource "aws_vpc" "vpc-2" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc-2-name
  }
}

# Public Subnet 1a
resource "aws_subnet" "vpc-2-subnet-public-1a" {
  vpc_id     = aws_vpc.vpc-2.id
  cidr_block = "10.2.1.0/24"

  tags = {
    Name = "${var.vpc-2-name}-subnet-public-1a"
  }
}

# Public Subnet 1b
resource "aws_subnet" "vpc-2-subnet-public-1b" {
  vpc_id     = aws_vpc.vpc-2.id
  cidr_block = "10.2.2.0/24"

  tags = {
    Name = "${var.vpc-2-name}-subnet-public-1b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "vpc-2-igw" {
  vpc_id = aws_vpc.vpc-2.id

  tags = {
    Name = "${var.vpc-2-name}-igw-1"
  }
}

# Router tables public subnets
resource "aws_route_table" "rt-vpc-2-public-subnet" {
  vpc_id = aws_vpc.vpc-2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-2-igw.id
  }

  tags = {
    Name = "${var.vpc-2-name}-rt-public-subnet"
  }
}

# Router tables public subntes association
resource "aws_route_table_association" "rta-vpc-2-public-subnet-1a" {
  subnet_id      = aws_subnet.vpc-2-subnet-public-1a.id
  route_table_id = aws_route_table.rt-vpc-2-public-subnet.id
}
resource "aws_route_table_association" "rta-vpc-2-public-subnet-1b" {
  subnet_id      = aws_subnet.vpc-2-subnet-public-1b.id
  route_table_id = aws_route_table.rt-vpc-2-public-subnet.id
}

# Security groups
resource "aws_security_group" "vpc-2-sg-allow-ssh-by-ip" {
  name        = "vpc_2_sg_allow_ssh_by_ip"
  description = "Security group para permitir conexao ssh por um ip especifico"
  vpc_id      = aws_vpc.vpc-2.id

  ingress {
    description = "Permite conexao ssh por um ip especifico"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed-iplist
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc-2-name}-sg-allow-ssh-by-ip"
  }
}