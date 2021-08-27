variable "dynamodb-table_name" {
  default = "mytable"
}

variable "dynamodb-read_capacity" {
  default = 5
}

variable "dynamodb-write_capacity" {
  default = 5
}

variable "dynamodb-hash_key" {
  default = "ID"
}

variable "dynamodb-attribute_name" {
  default = "ID"
}

variable "dynamodb-attribute_type" {
  default = "S"
}

variable "dynamodb-data_file" {
  default = "data.json"
}