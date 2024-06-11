// Odoo launch template
resource "aws_launch_template" "ltplt-odoo-v1" {

  name                   = "ltplt-odoo-v1"
  update_default_version = true

  // Application and OS Images (Amazon Machine Image) 
  // AMI criada na etata de setup.
  image_id = data.terraform_remote_state.remote-ami.outputs.ami-id

  // Instance type
  instance_type = "t3a.small"

  // Key pair (login)
  key_name = "aws-dev-console-admin"

  // Network settings
  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id
  ]

  # security_group_names = [
  #   data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-name
  # ]

  # network_interfaces {
  #   associate_public_ip_address = false
  #   security_groups = [
  #     data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-allow-all-id
  #   ]
  # }

  // Resource tags
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "elb-odoo-v1"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "ebs-elb-odoo-v1"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      Name = "eni-elb-odoo-v1"
    }
  }

  // Advanced details
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = false
  }

  // ebs_optimized = true
}

