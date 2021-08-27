output "s3_bucket-arn" {
  value = aws_s3_bucket.tf.arn
}

output "s3_bucket-website_endpoint" {
  value = aws_s3_bucket.tf.website_endpoint
}