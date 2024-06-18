resource "aws_instance" "vm-1" {
  # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  ami = "ami-04b70fa74e45c3917"
  # Apenas odoo
  #ami           = "ami-05e382370b66343e8"
  instance_type = "t3a.large"
  key_name      = "aws-dev-console-admin"
  subnet_id     = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id

  root_block_device {
    volume_size = 30
  }

  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id
  ]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  user_data = templatefile(
    "${path.module}/ec2-userdata-odoo-git.tftpl", {
      efs-odoo-mountpoint    = data.terraform_remote_state.remote-state-efs.outputs.efs-odoo-endpoint,
      rds-postgres-endpoint    = split(":", data.terraform_remote_state.remote-state-rds-postgres.outputs.rds-postgres-rds-1-endpoint)[0]
    }
  )

  provisioner "remote-exec" {
  
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${var.AWS_SSH_PRIVATE_KEY}"
      host        = self.public_ip
    }

    inline = [
      "while [ ! -f /tmp/userdata_finished ]; do",
      "tail -n /var/log/cloud-init-output.log",
      "sleep 15",
      "done"
    ]
  }

  tags = {
    Name = "vm-odoo-setup"
  }
}



