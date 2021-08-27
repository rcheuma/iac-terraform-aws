resource "aws_dynamodb_table" "tf" {
  name           = var.dynamodb-table_name
  read_capacity  = var.dynamodb-read_capacity
  write_capacity = var.dynamodb-write_capacity
  hash_key       = var.dynamodb-hash_key

  attribute {
    name = var.dynamodb-attribute_name
    type = var.dynamodb-attribute_type
  }
}

resource "aws_dynamodb_table_item" "tf" {
  table_name = aws_dynamodb_table.tf.name
  hash_key   = aws_dynamodb_table.tf.hash_key
  item       = file(var.dynamodb-data_file)
}