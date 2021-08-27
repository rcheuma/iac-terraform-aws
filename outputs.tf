output "public_dns" {
  value = module.ec2_nginx.public_dns
}

output "public_ip" {
  value = module.ec2_nginx.public_ip
}

output "subnet-prive-subnet-id" {
  value = module.subnet_prive.subnet-id
}

output "elb-dns_name" {
  value = module.elb.dns_name
}

output "s3_bucket-arn" {
  value = module.s3-bucket.s3_bucket-arn
}

output "s3_bucket-website_endpoint" {
  value = module.s3-bucket.s3_bucket-website_endpoint
}

output "ecr_url" {
  value = module.ecr.ecr_url
}