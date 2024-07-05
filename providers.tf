terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile_name
}

data "aws_availability_zones" "available" {}

provider "http" {}
provider "helm" {

}
