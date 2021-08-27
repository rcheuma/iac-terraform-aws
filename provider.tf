terraform {
  #required_version = ">=0.12,<0.13"
  #required_version = "3.54.0"
}

provider "aws" {
  profile = "formation"
  region  = var.region

  default_tags {
    tags = local.default_tags
  }
}
