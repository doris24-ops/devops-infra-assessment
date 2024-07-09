output "ecr_repo_urls"{
  value = { for k, v in aws_ecr_repository.ecr : k => v.repository_url }
}