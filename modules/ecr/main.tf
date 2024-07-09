# ECR
locals {
  resource_name = "${var.project_name}-${var.environment_name}"
}

resource "aws_ecr_repository" "ecr" {
  for_each = toset(var.service_repo_name)
  name                 = "${local.resource_name}-${each.value}"
  image_tag_mutability = "MUTABLE"
  force_delete = false

  

  image_scanning_configuration {
    scan_on_push = true
  }

  
}