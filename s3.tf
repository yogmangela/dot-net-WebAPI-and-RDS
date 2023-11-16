resource "aws_s3_bucket" "codebuild" {
  bucket = "dot-net-rds-codebuild"
}

resource "aws_s3_bucket_acl" "codebuild" {
  bucket = "aws_s3_bucket.codebuild"
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_codebuid" {
  bucket = aws_s3_bucket.codebuild.id
  versioning_configuration {
    status = "Enabled"
  }
}