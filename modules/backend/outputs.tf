output "tf_state_bucket" {
  description = "Nombre del bucket para el remote state"
  value       = aws_s3_bucket.tf_state.bucket
}

output "tf_locks_table" {
  description = "Nombre de la tabla DynamoDB para locking"
  value       = aws_dynamodb_table.tf_locks.name
}
