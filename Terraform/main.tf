terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source      = "./modules/networking"
  project     = var.project
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "eks" {
  source          = "./modules/eks"
  project         = var.project
  environment     = var.environment
  vpc_id          = module.networking.vpc_id
  private_subnets = module.networking.private_subnet_ids
}

module "rds" {
  source          = "./modules/rds"
  project         = var.project
  environment     = var.environment
  vpc_id          = module.networking.vpc_id
  private_subnets = module.networking.private_subnet_ids
  db_password     = var.db_password
}

module "elasticache" {
  source          = "./modules/elasticache"
  project         = var.project
  private_subnets = module.networking.private_subnet_ids
  vpc_id          = module.networking.vpc_id
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "sqs" {
  source  = "./modules/sqs"
  project = var.project
}

module "ecr" {
  source   = "./modules/ecr"
  project  = var.project
  services = ["auth", "flag", "targeting", "evaluation", "analytics"]
}