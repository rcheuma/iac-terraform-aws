resource "aws_s3_bucket" "tf" {
  bucket = var.s3-bucket_name
  acl    = var.s3-acl
  website {
    index_document = "index.html"
  }

  tags = {
    Name = var.s3-tag
  }
}