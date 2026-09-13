variable "project" {
  description = "Bases de dados TechChallenge3"
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

variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}
