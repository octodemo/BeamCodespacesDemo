variable "github_token" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token with Repository and Packages Access"
}

variable "github_context" {
  type = object({
    actor = string

    template_repository = object({
      owner = string
      repo  = string
    })

    target_repository = object({
      owner = string
      repo  = string
    })

    demo_config = optional(object({
    }))
  })
}

variable "azure_context" {
  type = map(any)
  default = {}
  description = "Azure specific context configuration data"
}

variable "gcp_context" {
  type = map(any)
  default = {}
  description = "GCP specific context configuration data"
}

variable "aws_context" {
  type = map(any)
  default = {}
  description = "AWS specific context configuration data"
}

variable "cloud_context" {
  type = map(any)
  default = {}
  description = "Cloud configuration data that is common to all cloud implementations"
}
