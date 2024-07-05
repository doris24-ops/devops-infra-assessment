locals {
  cluster_name = var.cluster_name
}

###############################
## VPC MODULE
###############################
module "vpc" {
  ############################ VPC VARIABLES ##########################
  source                     = "./modules/vpc"
  project_name               = var.project_name
  aws_region                 = var.aws_region
  vpc_cidr_block             = var.vpc_cidr_block
  environment_name           = var.environment_name
  cluster_name               = local.cluster_name
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}
