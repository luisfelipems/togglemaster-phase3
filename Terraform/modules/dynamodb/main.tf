resource "aws_dynamodb_table" "analytics" {
    name = "ToggleMasterAnalytics"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "flagId"
    range_key = "timestamp"

    attribute {
        name = "flagId"
        type = "S"
    }

    attribute {
        name = "timestamp"
        type = "S"
    }

    tags = {
        Name = "ToggleMasterAnalytics"
    }
}
