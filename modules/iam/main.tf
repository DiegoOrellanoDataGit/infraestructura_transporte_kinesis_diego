resource "aws_iam_role" "firehose_role" {
  name = "${var.nombre_proyecto}-${var.environment}-firehose-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "firehose.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "firehose_policy" {
  role = aws_iam_role.firehose_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kinesis:DescribeStream",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords"
        ]
        Resource = "arn:aws:kinesis:us-east-1:326998154370:stream/infraestructura-transporte-kinesis-aws-dev-event-stream"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = "arn:aws:s3:::infraestructura-transporte-kinesis-aws-dev-bucket/*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "flink_role" {
   name = "${var.nombre_proyecto}-${var.environment}-flink-role"

   assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [{
        Effect = "Allow"
        Principal = {
          Service = "kinesisanalytics.amazonaws.com"
        }
        Action ="sts:AssumeRole"
      }]
    } )
}

resource "aws_iam_role_policy" "flink_policy" {
  role = aws_iam_role.flink_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "KinesisReadAccess"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
      
    "arn:aws:s3:::infraestructura-transporte-kinesis-aws-dev-flink-code",
    "arn:aws:s3:::infraestructura-transporte-kinesis-aws-dev-flink-code/*"
 
        ]
      },
      {
        Sid = "CloudWatchLogAccess"
        Effect = "Allow"
        Action =[
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream"
        ]
        Resource = "*"
      }
    ]
  })
}