output "s3_bucket_arn" {
  description = "ARN del bucket S3 creado"
  value       = aws_s3_bucket.data_lake.arn
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = aws_s3_bucket.data_lake.bucket
}

