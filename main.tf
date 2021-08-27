module "key-pair" {
  source                   = "./modules/key-pair"
  key_pair_public_key_file = var.public_key_file
}

module "ec2-default-vpc" {
  source = "./modules/ec2-default-vpc"
}

module "iam-policy-s3" {
  source             = "./modules/iam-policy-s3"
  iam_policy_s3-name = var.name
  iam_policy_s3-path = var.path
}

module "vpc_1_subnet_public" {
  source                 = "./modules/vpc_1_subnet_public"
  vpc-cidr               = var.vpc_cidr
  vpc-availability_zones = var.vpc_availability_zones
  vpc-name               = var.vpc_name
}

module "ec2_nginx" {
  source                = "./modules/ec2_nginx"
  ec2_instance_type     = var.instance_type
  ec2_instance_name     = var.instance_name
  ec2_instance_ami      = var.instance_ami
  ec2_instance_key_name = var.instance_key_name
  ec2_vpc_id            = module.vpc_1_subnet_public.vpc_id
  ec2_subnet_id         = module.vpc_1_subnet_public.subnet_id
}
module "subnet_prive" {
  source                 = "./modules/subnet_prive"
  vpc_availability_zones = var.vpc_availability_zones
  vpc_cidr               = var.vpc_cidr
  vpc_id                 = module.vpc_1_subnet_public.vpc_id
  vpc_nat_gatewayid      = module.vpc_1_subnet_public.nat_gateway-id
}

module "second_subnet_public" {
  source                 = "./modules/second_subnet_public"
  vpc-availability_zones = var.vpc_availability_zones
  vpc-cidr               = var.vpc_cidr
  vpc-id                 = module.vpc_1_subnet_public.vpc_id
  vpc-igw                = module.vpc_1_subnet_public.igw-id
}

module "elb" {
  source = "./modules/elb"
}

module "asg" {
  source            = "./modules/asg"
  asg-elb-name      = module.elb.name
  asg-min_size      = var.min_size
  asg-max_size      = var.max_size
  asg-image_id      = var.image_id
  asg-instance_type = var.instance_type
  asg-key_name      = var.key_name
}

module "cloudfront-distribution" {
  source                              = "./modules/cloudfront-distribution"
  cloudfront_distribution-origin_id   = var.origin_id
  cloudfront_distribution-domain_name = module.s3-bucket.s3_bucket-website_endpoint #module.s3-bucket.s3_bucket-arn
}

module "s3-bucket" {
  source           = "./modules/s3-bucket"
  s3_bucket-bucket = var.domain_name
}

module "cloudwatch-alarm" {
  source                       = "./modules/cloudwatch-alarm"
  cloudwatch_alarm-threshold   = var.threshold
  cloudwatch_alarm-period      = var.period
  cloudwatch_alarm-description = var.description
}

module "dynamodb" {
  source              = "./modules/dynamodb"
  dynamodb-table_name = var.table_name
  dynamodb-data_file  = var.data_file
}

module "ecr" {
  source   = "./modules/ecr"
  ecr-name = var.ecr_name
}

module "lambda_function" {
  source               = "./modules/lambda_function"
  lambda-function_name = "helloworld"
  lambda-runtime       = "python2.7"
}

data "aws_caller_identity" "current" {}

module "api_gateway" {
  source                      = "./modules/api_gateway"
  api_gateway-function_name   = "helloworld"
  api_gateway-method          = "GET"
  api_gateway-lambda_function = module.lambda_function.function_name
  api_gateway-region          = var.region
  api_gateway-account_id      = data.aws_caller_identity.current.account_id
}

module "rds" {
  source       = "./modules/rds"
  rds-username = var.postgres-username
  rds-password = var.postgres-password
}

module "route53-record" {
  source              = "./modules/route53-record"
  route53-record_name = var.dns_record_name
  route53-ip_address  = var.dns_ip_address
  route53-zone_id     = var.dns-zone_id
}

module "s3" {
  source         = "./modules/s3"
  s3-bucket_name = var.bucket_name
  s3-tag         = var.tag
}