resource "aws_s3_bucket" "s3-remote-state" {
  bucket = "remote-state-odoo"
}

resource "aws_s3_bucket_versioning" "versionamento-s3-remote-state" {
  bucket = aws_s3_bucket.s3-remote-state.id
  versioning_configuration {
    status = "Enabled"
  }
}