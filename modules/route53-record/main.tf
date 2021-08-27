resource "aws_route53_record" "tf" {
  zone_id = var.route53-zone_id
  name    = var.route53-record_name
  records = [var.route53-ip_address]
  type    = "A"
  ttl     = "300"
}