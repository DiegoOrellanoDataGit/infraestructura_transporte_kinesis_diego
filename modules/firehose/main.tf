resource "aws_kinesis_firehose_delivery_stream" "hacia_s3" {
  name = "${var.nombre_proyecto}-${var.environment}-firehose"
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = var.event_stream_arn
    role_arn = var.firehose_role_arn
  }

  extended_s3_configuration {
     role_arn           = var.firehose_role_arn
    bucket_arn         = var.s3_bucket_arn
    buffering_size     = var.buffering_size
    buffering_interval = var.buffering_interval
    compression_format = "GZIP"

    cloudwatch_logging_options {
      enabled = true
      log_group_name  = "/aws/kinesisfirehose/${var.nombre_proyecto}-${var.environment}-firehose"
      log_stream_name = "S3Delivery"
    }
  }


}