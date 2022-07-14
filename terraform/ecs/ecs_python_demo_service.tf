module "python_demo" {
  source = "/mnt/terraform-modules/ecs-service"

  output_config_file = true
  service_name       = "demo-python-api"
  cluster_id         = module.cluster.cluster_id
  namespace_id       = module.cluster.cluster_namespaces["pda"].namespace_id

  service_subnets = module.network.private_subnets

  service_security_groups = [
    aws_security_group.alb_sg.id
  ]

  tls_config = {
    expose_endpoint        = true
    public_zone_id         = data.aws_route53_zone.external.zone_id
    vpc_id                 = module.network.vpc_id
    alb_dns_name           = module.cluster.alb_dns_name
    alb_https_listener_arn = module.cluster.alb_https_listener_arn
    container_port         = "8000"
    public_dns_prefix      = "python"
  }

  tags = local.tags
}
