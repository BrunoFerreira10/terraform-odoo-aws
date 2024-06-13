// EFS addons
resource "aws_efs_file_system" "fs-efs-1" {
  creation_token  = "efs-odoo-addons"
  encrypted       = true
  throughput_mode = "elastic"

  tags = {
    Name = "efs-odoo-addons"
  }
}

resource "aws_efs_mount_target" "fs-efs-1-subnet-private-1a" {
  file_system_id = aws_efs_file_system.fs-efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1a-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-efs-mountpoints-id
  ]
}

resource "aws_efs_mount_target" "fs-efs-1-subnet-private-1b" {
  file_system_id = aws_efs_file_system.fs-efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1b-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-efs-mountpoints-id
  ]
}

resource "aws_efs_backup_policy" "fs-efs-1-backup-policy" {
  file_system_id = aws_efs_file_system.fs-efs-1.id

  backup_policy {
    status = "DISABLED"
  }
}

// EFS filestore
resource "aws_efs_file_system" "fs-efs-2" {
  creation_token  = "efs-odoo-filestore"
  encrypted       = true
  throughput_mode = "elastic"

  tags = {
    Name = "efs-odoo-filestore"
  }
}

resource "aws_efs_mount_target" "fs-efs-2-subnet-private-1a" {
  file_system_id = aws_efs_file_system.fs-efs-2.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1a-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-efs-mountpoints-id
  ]
}

resource "aws_efs_mount_target" "fs-efs-2-subnet-private-1b" {
  file_system_id = aws_efs_file_system.fs-efs-2.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1b-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-efs-mountpoints-id
  ]
}

resource "aws_efs_backup_policy" "fs-efs-2-backup-policy" {
  file_system_id = aws_efs_file_system.fs-efs-2.id

  backup_policy {
    status = "DISABLED"
  }
}

// EFS logs
resource "aws_efs_file_system" "fs-efs-3" {
  creation_token  = "efs-odoo-logs"
  encrypted       = true
  throughput_mode = "elastic"

  tags = {
    Name = "efs-odoo-logs"
  }
}

resource "aws_efs_mount_target" "fs-efs-3-subnet-private-1a" {
  file_system_id = aws_efs_file_system.fs-efs-3.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1a-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-efs-mountpoints-id
  ]
}

resource "aws_efs_mount_target" "fs-efs-3-subnet-private-1b" {
  file_system_id = aws_efs_file_system.fs-efs-3.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1b-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-efs-mountpoints-id
  ]
}

resource "aws_efs_backup_policy" "fs-efs-3-backup-policy" {
  file_system_id = aws_efs_file_system.fs-efs-3.id

  backup_policy {
    status = "DISABLED"
  }
}