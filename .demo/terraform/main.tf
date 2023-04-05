terraform {
  required_version = ">=1.1"
}

#
# backend is dynamically generated and injected by terragrunt
#

module "github" {
  source = "./modules/github"

  github_token        = var.github_token
  actor               = var.github_context.actor
  template_repository = var.github_context.template_repository
  target_repository   = var.github_context.target_repository
}

output "repository_url" {
  value       = module.github.repository_url
  description = "GitHub repository URL"
}

output "repository_full_name" {
  value       = module.github.repository_full_name
  description = "GitHub repository full name"
}

output "resource_tags" {
  value       = ""
}
