output "firehose_role_arn" {
  description = "ARN del rol IAM que firehose va a usar"
  value = aws_iam_role.firehose_role.arn
}

output "flink_role_arn" {
  description = "ARN del rol de IAM que ejecuta la aplicacion Flnk"
  value = aws_iam_role.flink_role.arn
}