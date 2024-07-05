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
###############################
## EKS MODULE
###############################
module "eks" {
  ############################ EKS VARIABLES #############################
  source                         = "./modules/eks"
  environment_name               = var.environment_name
  project_name                   = var.project_name
  cluster_version                = "1.29"
  cluster_endpoint_public_access = "true"
  aws_profile_name               = var.aws_profile_name
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.public_subnets_id
  private_subnet_ids             = module.vpc.private_subnets_id
  enabled_cluster_log_types      = ["audit"]

  # added eks ondemand nodegroup
  create_on_demand_ng        = true #by default true   #values= yes or false
  on_demand_instance_types   = ["t3.large"]
  eks_on_demand_desired_size = 1 # default 1
  eks_on_demand_min_size     = 1 # default 1
  eks_on_demand_max_size     = 3 # default 1             # default t3.medium

  # add eks onspot nodegroup
  create_spot_ng        = false                     # by default false  # values= yes or false
  eks_spot_desired_size = 1                         # default 1
  eks_spot_min_size     = 1                         # default 1
  eks_spot_max_size     = 3                         # default 1
  spot_instance_types   = ["t3.large", "t3.medium"] #  default t3.large

  #  addons for cluster autoscaler enable 
  enable_cluster_autoscaler = true
}

