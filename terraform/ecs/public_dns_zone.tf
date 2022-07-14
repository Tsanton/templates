data "aws_route53_zone" "external" {
  name         = var.public_dns_zone_domain_name
  private_zone = false
}
