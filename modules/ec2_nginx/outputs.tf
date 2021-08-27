output "public_dns" {
  value = aws_instance.tf.public_dns
}

output "public_ip" {
  value = aws_instance.tf.public_ip
}

