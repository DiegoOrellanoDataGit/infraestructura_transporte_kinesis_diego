resource "aws_kinesisanalyticsv2_application" "flink" {
  name                   = "${var.nombre_proyecto}-${var.environment}-flink"
  runtime_environment    = "FLINK-1_15"
  service_execution_role = var.flink_role_arn

  application_configuration {
application_code_configuration {
  code_content {
    s3_content_location {
      bucket_arn = var.flink_code_bucket_arn
      file_key   = var.flink_code_file_key
    }
  }
  code_content_type = "ZIPFILE"
}

    

    flink_application_configuration {
      checkpoint_configuration {
        configuration_type             = "CUSTOM"
        checkpointing_enabled          = true
        checkpoint_interval            = 60000
        min_pause_between_checkpoints  = 5000
      }

   monitoring_configuration {
  configuration_type = "CUSTOM"
  log_level           = "INFO"
  metrics_level       = "APPLICATION"
}

    }
  }
}

