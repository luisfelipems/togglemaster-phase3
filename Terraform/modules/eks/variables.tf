variable "project" {
  description = "EKS Tech TechChallenge2"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnets" {
  description = "Subnets privadas"
  type        = list(string)
}

variable "node_role_arn" {
  description = "ARN do role para os nodes"
  type        = string
  default     = null
}

variable "cluster_role_arn" {
  description = "ARN do role para o cluster"
  type        = string
  default     = null
}
