resource "aws_instance" "vm-bastion" {
  # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  ami = "ami-04b70fa74e45c3917"

  instance_type = "t3a.large"
  key_name      = "aws-dev-console-admin"
  subnet_id     = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id

  # root_block_device {
  #   volume_size = 30
  # }

  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id
  ]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  user_data = templatefile(
    "${path.module}/ec2-userdata.tftpl", {
      private_key_base64 = base64encode(var.AWS_SSH_PRIVATE_KEY)
    }
  )  

  tags = {
    Name = "vm-bastion-host"
  }
}



