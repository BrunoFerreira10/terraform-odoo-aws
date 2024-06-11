// EFS /opt/odoo
resource "aws_efs_file_system" "fs-efs-1" {
  creation_token = "rds-opt-odoo" 
  encrypted = true
  throughput_mode = "elastic"

  tags = {
    Name = "efs-opt-odoo"
  }
}

resource "aws_efs_mount_target" "fs-efs-1-subnet-public-1a" {
  file_system_id = aws_efs_file_system.fs-efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id
  security_groups = [ 
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id 
  ]  
}

resource "aws_efs_mount_target" "fs-efs-1-subnet-public-1b" {
  file_system_id = aws_efs_file_system.fs-efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1b-id
  security_groups = [ 
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id 
  ]  
}

resource "aws_efs_backup_policy" "fs-efs-1-backup-policy" {
  file_system_id = aws_efs_file_system.fs-efs-1.id

  backup_policy {
    status = "DISABLED"
  }
}

// EFS /etc/odoo
resource "aws_efs_file_system" "fs-efs-2" {
  creation_token = "rds-etc-odoo" 
  encrypted = true
  throughput_mode = "elastic"

  tags = {
    Name = "efs-etc-odoo"
  }
}

resource "aws_efs_mount_target" "fs-efs-2-subnet-public-1a" {
  file_system_id = aws_efs_file_system.fs-efs-2.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id
  security_groups = [ 
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id 
  ]  
}

resource "aws_efs_mount_target" "fs-efs-2-subnet-public-1b" {
  file_system_id = aws_efs_file_system.fs-efs-2.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1b-id
  security_groups = [ 
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id 
  ]  
}

resource "aws_efs_backup_policy" "fs-efs-2-backup-policy" {
  file_system_id = aws_efs_file_system.fs-efs-2.id

  backup_policy {
    status = "DISABLED"
  }
}