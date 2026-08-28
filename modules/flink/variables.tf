variable "nombre_proyecto" {
  type= string
  default = "infraestructura-transporte-kinesis-aws"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "flink_role_arn" {
  type = string
  description = "ARN del rol IAM que ejecuta la aplicacion Flink"
}

variable "flink_code_bucket_arn" {
  type = string
  description = "Bucket S3 donde esta el artefacto flink"
}

variable "flink_code_file_key" {
  type = string
  description = "Nombre del archivo JAR/ZIP en S3"
  default = "flink.zip"
}