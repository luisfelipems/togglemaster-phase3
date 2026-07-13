resource "aws_db_subnet_group" "main" {
    name = "${var.project}-db-subnet-group"
    subnet_ids = var.private_subnets
}

resource "aws_security_group" "rds" {
    name = "${var.project}-rds-sg"
    vpc_id = var.vpc_id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
}

locals {
  databases = ["authdb", "flagdb", "analyticsdb"]
}

resource "aws_db_instance" "main" {
    for_each = toset(local.databases)
    identifier = "${var.project}-${each.key}-db"
    engine = "postgres"
    engine_version = "15.18"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_name = each.key
    username = "luissilva"
    password = var.db_password
    db_subnet_group_name = aws_db_subnet_group.main.name
    vpc_security_group_ids = [aws_security_group.rds.id]
    skip_final_snapshot = true
    tags = { Name = "${var.project}-${each.key}-db" }
}