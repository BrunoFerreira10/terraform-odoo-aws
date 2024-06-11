output "remote_state_bucket_name" {
  description = "Name do bucket"
  value = aws_s3_bucket.s3-remote-state.bucket
}

output "remote_state_bucket_arn" {
  description = "Name do bucket"
  value = aws_s3_bucket.s3-remote-state.arn
}