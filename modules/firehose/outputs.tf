output "firehose_delivery_name" {
  value = aws_kinesis_firehose_delivery_stream.hacia_s3.name
}
output "firehose_arn" {
  value = aws_kinesis_firehose_delivery_stream.hacia_s3.arn
}