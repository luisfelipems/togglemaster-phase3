variable "aws_region" {
    description = "Regiao AWS"
    default = "sa-east-1"
}

variable "project" {
    description = "Tech Challenge2"
    default = "togglemaster"
}

variable "environment" {
    description = "Ambiente (production, staging, dev)"
    default = "production"
}

variable "vpc_cidr" {
    description = "CIDR da VPC"
    default = "10.0.0.0/16"
}

variable "db_password" {
    description = "TechChallenge2"
    sensitive = true
}

variable "lab_role_arn" {
    description = "ARN da Lab Role do AWS Academy"
    default = "arn:aws:iam::ACCOUNT_ID:role/LabRole"
}