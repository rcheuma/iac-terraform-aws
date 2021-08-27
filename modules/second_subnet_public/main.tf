resource "aws_subnet" "tf-subnet-public-2" {
  vpc_id                  = var.vpc-id
  cidr_block              = cidrsubnet(var.vpc-cidr, 8, 3)
  availability_zone       = element(split(",", var.vpc-availability_zones), 1)
  map_public_ip_on_launch = true

  # tags = {
  # Name = "tf-public-2"
  #}
}

resource "aws_route_table" "tf-subnet-public-2" {
  vpc_id = var.vpc-id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.vpc-igw
  }

  #tags = {
  #Name = "tf-public-2"
  #}
}

resource "aws_route_table_association" "tf-subnet-public-2" {
  subnet_id      = aws_subnet.tf-subnet-public-2.id
  route_table_id = aws_route_table.tf-subnet-public-2.id
}