# VPC
resource "aws_vpc" "vpc-1" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc-1-name
  }
}

# Network ACL
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc-1.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.vpc-1-name}-acl"
  }
}

# Public Subnet 1a
resource "aws_subnet" "vpc-1-subnet-public-1a" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.vpc-1-name}-subnet-public-1a"
  }
}

# Public Subnet 1b
resource "aws_subnet" "vpc-1-subnet-public-1b" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.vpc-1-name}-subnet-public-1b"
  }
}

# Private Subnet 1a
resource "aws_subnet" "vpc-1-subnet-private-1a" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.vpc-1-name}-subnet-private-1a"
  }
}

# Private Subnet 1b
resource "aws_subnet" "vpc-1-subnet-private-1b" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.vpc-1-name}-subnet-private-1b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "vpc-1-igw" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "${var.vpc-1-name}-igw-1"
  }
}

# Router tables 
resource "aws_route_table" "rt-vpc-1-public-subnet" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-1-igw.id
  }

  tags = {
    Name = "${var.vpc-1-name}-rt-public-subnet"
  }
}

resource "aws_route_table" "rt-vpc-1-private-subnet" {
  vpc_id = aws_vpc.vpc-1.id  

  tags = {
    Name = "${var.vpc-1-name}-rt-private-subnet"
  }
}

# Router tables public subnets association
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1a" {
  subnet_id      = aws_subnet.vpc-1-subnet-public-1a.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnet.id
}
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1b" {
  subnet_id      = aws_subnet.vpc-1-subnet-public-1b.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnet.id
}

# Router tables private subnets association
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1a" {
  subnet_id      = aws_subnet.vpc-1-subnet-private-1a.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnet.id
}
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1b" {
  subnet_id      = aws_subnet.vpc-1-subnet-private-1b.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnet.id
}

# Security groups
resource "aws_security_group" "vpc-1-sg-allow-all" {
  name        = "vpc_1_sg_allow_all"
  description = "Security group para permitir tudo"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc-1-name}-sg-allow-all"
  }
}

resource "aws_security_group" "vpc-1-sg-allow-ssh-by-ip" {
  name        = "vpc_1_sg_allow_ssh_by_ip"
  description = "Security group para permitir conexao ssh por um ip especifico"
  vpc_id      = aws_vpc.vpc-1.id

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
    Name = "${var.vpc-1-name}-sg-allow-ssh-by-ip"
  }
}