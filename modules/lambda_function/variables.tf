variable "lambda-account_id" { default = "" }

variable "lambda-function_name" { default = "" }

variable "lambda-region" { default = "" }

variable "lambda-runtime" {
  default = "nodejs"
}

variable "lambda-handler" {
  default = "handler"
}
