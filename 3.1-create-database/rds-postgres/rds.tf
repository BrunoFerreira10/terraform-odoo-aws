resource "aws_db_subnet_group" "rds-1-subnet-group" {
  name = "rds-1-subnet-group"
  subnet_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1b-id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds-1" {
  allocated_storage    = 20
  db_name              = "postgres"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "odoo"
  password             = "12345678"
  parameter_group_name = "default.postgres16"
  db_subnet_group_name = aws_db_subnet_group.rds-1-subnet-group.name
  skip_final_snapshot  = true
  multi_az             = false

  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-rds-id
  ]
}