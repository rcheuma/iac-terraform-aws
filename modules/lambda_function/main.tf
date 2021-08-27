resource "aws_lambda_function" "tf" {
  filename = "${var.lambda-function_name}.zip"
  function_name = var.lambda-function_name
  role = aws_iam_role.tf.arn
  handler = "${var.lambda-function_name}.${var.lambda-handler}"
  runtime = var.lambda-runtime
}
resource "aws_iam_role" "tf" {
  name = "iam_role_for_lambda"

  assume_role_policy = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
CONTENT
}