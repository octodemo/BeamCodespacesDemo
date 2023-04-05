variable "github_token" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token with Repository and Packages Access"
}

variable "actor" {
  type        = string
  description = "The user that has requested the demo repository"
}

variable "template_repository" {
  type = object({
    owner = string
    repo  = string
  })
  description = "The template repository to create the demo from"
}

variable "target_repository" {
  type = object({
    owner = string
    repo  = string
  })
  description = "The repository target to create"
}

variable "create_project" {
  type        = bool
  default     = false
  description = "Flag to create project features on the repository"
}