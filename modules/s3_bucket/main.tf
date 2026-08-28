resource "aws_s3_bucket" "data_lake" {
  bucket = "${var.nombre_proyecto}-${var.environment}-data-lake"
  tags = {
    Environment = var.environment
    Project = var.nombre_proyecto
  }

}