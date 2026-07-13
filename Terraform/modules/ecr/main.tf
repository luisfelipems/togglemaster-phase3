resource "aws_ecr_repository" "services" {
    for_each = toset(var.services)
    name = "${var.project}/${each.key}"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration { scan_on_push = true }
    tags = { Name = "${var.project}-${each.key}-ecr" }
}

output "repository_urls" {
    value = { for k, v in aws_ecr_repository.services : k => v.repository_url }
}
