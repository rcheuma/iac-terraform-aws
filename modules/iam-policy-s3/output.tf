output "iam_policy_s3-access_key-id" {
  value = aws_iam_access_key.tf.id
}

output "iam_policy_s3-access_key-secret" {
  value = aws_iam_access_key.tf.secret
}