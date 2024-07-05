aws_region                 = "eu-west-1"
cluster_name               = "devops-eks"
project_name               = "devops"
aws_profile_name           = "default"
environment_name           = "test"
vpc_cidr_block             = "10.0.0.0/16"
public_subnet_cidr_blocks  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]