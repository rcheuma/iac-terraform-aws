output "vpc_id" {
  value = aws_vpc.tf.id
}
output "nat_gateway-public_ip" {
  value = aws_nat_gateway.tf.public_ip
}

output "igw-id" {
  value = aws_internet_gateway.tf.id
}

output "nat_gateway-id" {
  value = aws_nat_gateway.tf.id
}

output "subnet_id" {
  value = aws_subnet.tf-public-1.id
}