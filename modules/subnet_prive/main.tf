resource "aws_subnet" "tf-subnet-private" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 2)
  availability_zone       = element(split(",", var.vpc_availability_zones), 0)
  map_public_ip_on_launch = false

  # tags = {
  # Name = "tf-private"
  # }
}

resource "aws_route_table" "tf-subnet-private" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.vpc_nat_gatewayid
  }

  tags = {
    Name = "tf-private"
  }
}

resource "aws_route_table_association" "tf-subnet-private" {
  subnet_id      = aws_subnet.tf-subnet-private.id
  route_table_id = aws_route_table.tf-subnet-private.id
}