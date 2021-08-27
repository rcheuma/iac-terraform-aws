resource "aws_api_gateway_rest_api" "tf" {
  name = "helloworld"
}
resource "aws_api_gateway_resource" "tf" {
  path_part = "hello"
  rest_api_id = aws_api_gateway_rest_api.tf.id
  parent_id = aws_api_gateway_rest_api.tf.root_resource_id
}

resource "aws_api_gateway_method" "tf" {
  rest_api_id = aws_api_gateway_rest_api.tf.id
  resource_id = aws_api_gateway_resource.tf.id
  http_method = var.api_gateway-method
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "tf" {
  rest_api_id = aws_api_gateway_rest_api.tf.id
  resource_id = aws_api_gateway_resource.tf.id
  http_method = aws_api_gateway_integration.tf.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "tf" {
  rest_api_id = aws_api_gateway_rest_api.tf.id
  resource_id = aws_api_gateway_resource.tf.id
  http_method = aws_api_gateway_method.tf.http_method
  type = "AWS"
  uri = "arn:aws:apigateway:${var.api_gateway-region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.api_gateway-region}:${var.api_gateway-account_id}:function:${var.api_gateway-lambda_function}/invocations"
  integration_http_method = "POST"
}

resource "aws_api_gateway_integration_response" "tf" {
  rest_api_id = aws_api_gateway_rest_api.tf.id
  resource_id = aws_api_gateway_resource.tf.id
  http_method = aws_api_gateway_method_response.tf.http_method
  status_code = aws_api_gateway_method_response.tf.status_code
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_lambda_permission" "tf" {
  function_name = var.api_gateway-function_name
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.api_gateway-region}:${var.api_gateway-account_id}:${aws_api_gateway_rest_api.tf.id}/*/${var.api_gateway-method}${aws_api_gateway_resource.tf.path}"
  #arn:aws:lambda:us-east-1:275601082040:function:helloworld_handler
}

resource "aws_api_gateway_deployment" "tf" {
  rest_api_id = aws_api_gateway_rest_api.tf.id
  stage_name  = "production"
  description = "tf"
  depends_on = [aws_api_gateway_method.tf, aws_api_gateway_integration.tf]
}