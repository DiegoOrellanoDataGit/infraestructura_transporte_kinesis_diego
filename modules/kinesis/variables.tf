variable "environment" {
  type = string
  description = "nombre del entorno de ddesarrollo"
  default = "dev"
}
variable "nombre_proyecto" {
  type = string
  description = "nombre del proyecto"
  default = "infraestructura-transporte-kinesis-aws"
}
variable "shard_count" {
  type = number
  description = "conteo del shard"
default = 2
}
variable "kms_key_id" {
  type = string
  description = "llave identificadora unica de kms"
}