resource "aws_iam_user" "tf" {
  name = var.iam_policy_s3-name
  path = var.iam_policy_s3-path
}




resource "aws_iam_access_key" "tf" {
  user = aws_iam_user.tf.name
}

resource "aws_iam_user_policy_attachment" "tf" {
  user       = aws_iam_user.tf.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}