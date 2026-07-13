variable "project" {
  description = "Elasticache TechChallenge2"
  type        = string
}

variable "private_subnets" {
  description = "Subnets privadas"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}
