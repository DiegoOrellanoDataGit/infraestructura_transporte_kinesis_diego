resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.nombre_proyecto}-${var.environment}-tfstate"

  tags = {
    Environment = var.environment
    Project     = var.nombre_proyecto
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "${var.nombre_proyecto}-${var.environment}-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Project     = var.nombre_proyecto
  }
}
