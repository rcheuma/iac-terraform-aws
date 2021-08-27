locals {
  user = "rostand"
  tp   = "formation-terraform-aws"
}

locals {
  default_tags = {
    Owner = local.user
    TP    = local.tp
  }
}
