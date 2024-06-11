locals {
  user_data_var = <<EOT
#!/bin/bash
echo "##### Export RDS"
export RDS_POSTGRES_ENDPOINT=${data.terraform_remote_state.remote-state-rds-postgres.outputs.rds-postgres-rds-1-endpoint}
echo "##### Criando arquivo env"
touch /etc/profile.d/app_env_var.sh
chmod 755 /etc/profile.d/app_env_var.sh
echo "export RDS_POSTGRES_ENDPOINT=${data.terraform_remote_state.remote-state-rds-postgres.outputs.rds-postgres-rds-1-endpoint}" >> /etc/profile.d/app_env_var.sh
echo "##### Finalizado usar_data_var"
EOT

  rds-postgres-endpoint = split(":",data.terraform_remote_state.remote-state-rds-postgres.outputs.rds-postgres-rds-1-endpoint)[0]
}

resource "aws_instance" "vm-1" {
  # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  ami           = "ami-07640bd91e0db7730"
  instance_type = "t3a.micro"
  key_name      = "aws-dev-console-admin"
  subnet_id     = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id
  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id
  ]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  # user_data                   = "${file("./ec2-odoo-setup/ec2-userdata.sh")}"
  # user_data = format(
  #   "%s %s", 
  #   local.user_data_var, file("./ec2-odoo-efs/ec2-userdata.sh")
  # )
  user_data = templatefile("./ec2-odoo-efs/user-data.tftpl", {
    rds-postgres-endpoint = local.rds-postgres-endpoint
  })

  tags = {
    Name = "vm-odoo-setup"
  }
}