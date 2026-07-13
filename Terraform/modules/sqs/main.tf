resource "aws_sqs_queue" "main" {
    name = "${var.project}-events"
    delay_seconds = 0
    message_retention_seconds = 86400
    visibility_timeout_seconds = 30
    tags = { Name = "${var.project}-events-queue" }
}
