resource "aws_sqs_queue" "main" {
  name                       = "${var.project}-events"
  delay_seconds              = 0
  message_retention_seconds  = 86400
  visibility_timeout_seconds = 30

  # ← adicionar este bloco
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = { Name = "${var.project}-events-queue" }
}

# ← adicionar este recurso inteiro
resource "aws_sqs_queue" "dlq" {
  name                      = "${var.project}-events-dlq"
  message_retention_seconds = 1209600 # 14 dias
  tags                      = { Name = "${var.project}-events-dlq" }
}