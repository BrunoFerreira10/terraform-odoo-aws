resource "aws_instance" "vm-1" {
  # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t3a.micro"
  key_name      = "aws-dev-console-admin"
  subnet_id     = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id
  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id
  ]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  user_data                   = templatefile(
    "./ec2-odoo-setup/ec2-userdata.tftpl", {
      efs-opt-mountpoint = aws_efs_file_system.fs-efs-1.id,
      efs-etc-mountpoint = aws_efs_file_system.fs-efs-2.id,
      rds-postgres-endpoint = split(":",data.terraform_remote_state.remote-state-rds-postgres.outputs.rds-postgres-rds-1-endpoint)[0]
    }
  )

  tags = {
    Name = "vm-odoo-setup"
  }
}