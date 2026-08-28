variable "nombre_proyecto" {
  type = string
  description = "nombre del proyecto"
  default = "infraestructura-transporte-kinesis-aws"
}

variable "environment" {
  type = string
  description = "nombre del entorno de ddesarrollo"
  default = "dev"
}

variable "event_stream_arn" {
  type = string
  description = "ARN del Kinesis Data Stream que actúa como fuente."
}

variable "firehose_role_arn" {
  type = string
  description = "ARN del rol IAM que Firehose usará para permisos."
}

variable "s3_bucket_arn" {
  type = string
  description = "ARN del bucket S3 destino para almacenar los datos."
}

variable "buffering_size" {
  type = number
  description = "Tamaño del buffer medido en MB antes de entregar a S3"
  default = 5
}

variable "buffering_interval" {
  type = number
  description = "Intervalo de tiempo medido en segundos para entrega datos a S3"
  default = 60
}