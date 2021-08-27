resource "aws_vpc" "tf" {
  cidr_block = var.vpc-cidr

  # tags = {
  # Name = var.vpc-name
  # }
}
resource "aws_internet_gateway" "tf" {
  vpc_id = aws_vpc.tf.id

  tags = {
    Name = "tf"
  }
}

resource "aws_eip" "tf" {
  vpc = true

  tags = {
    Name = "tf"
  }
}

resource "aws_nat_gateway" "tf" {
  allocation_id = aws_eip.tf.id
  subnet_id     = aws_subnet.tf-public-1.id
  depends_on    = [aws_internet_gateway.tf]

  tags = {
    Name = "tf"
  }
}

resource "aws_subnet" "tf-public-1" {
  vpc_id                  = aws_vpc.tf.id
  cidr_block              = cidrsubnet(var.vpc-cidr, 8, 1)
  availability_zone       = var.vpc-availability_zones
  map_public_ip_on_launch = true

  #tags = {
  # Name = "tf-public-1"
  #}
}

resource "aws_route_table" "tf-public-1" {
  vpc_id = aws_vpc.tf.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf.id
  }

  #tags = {
  # Name = "tf-public-1"
  #}
}

resource "aws_route_table_association" "tf-public-1" {
  subnet_id      = aws_subnet.tf-public-1.id
  route_table_id = aws_route_table.tf-public-1.id
}


