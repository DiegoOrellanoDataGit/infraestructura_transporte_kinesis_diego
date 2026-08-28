module "iam_roles" {
  source = "../../modules/iam"
  environment = var.environment
  policy_json = file("../../policies/firehose.json")
 event_stream_arn = module.kinesis.event_stream_arn
 flink_checkpoint_bucket_arn = var.flink_checkpoint_bucket_arn
}

module "kinesis" {
  source = "../../modules/kinesis"
  environment = var.environment
  shard_count = var.shard_count
  kms_key_id = var.kms_key_id
}

module "backend" {
  source          = "../../modules/backend"
  environment     = var.environment
  nombre_proyecto = var.nombre_proyecto
}

terraform {
  backend "s3" {
    bucket       = "infraestructura-transporte-kinesis-aws-dev-tfstate-diego"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"
  environment = var.environment
  nombre_proyecto = var.nombre_proyecto
}

module "firehose" {
  source = "../../modules/firehose"
  environment = var.environment
  event_stream_arn = module.kinesis.event_stream_arn
  firehose_role_arn = module.iam_roles.firehose_role_arn
  s3_bucket_arn = var.s3_bucket_arn

}

module "flink" {
  source = "../../modules/flink"
  environment = var.environment
  nombre_proyecto = var.nombre_proyecto
   flink_role_arn = module.iam_roles.flink_role_arn  
 flink_code_bucket_arn = var.flink_code_bucket_arn
 flink_code_file_key = var.flink_code_file_key

}