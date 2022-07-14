resource "aws_security_group" "alb_sg" {
  name   = "demo-alb-sg"
  vpc_id = module.network.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow access from self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.tags, {
    Name = "demo-alb-sg"
  })
}


module "cluster" {
  source = "/mnt/terraform-modules/ecs-cluster"

  naming_prefix = "cd-demo"

  internal_load_balancer = false

  vpc_id = module.network.vpc_id

  cluster_namespaces = {
    "pda" : "internal.pda",
    "ips" : "internal.ips"
  }

  alb_subnets = module.network.public_subnets

  alb_security_groups = [
    aws_security_group.alb_sg.id
  ]

  tls_config = {
    enable_https_listener = true
    public_zone_id        = data.aws_route53_zone.external.zone_id
    default_dns_prefix    = "home"
  }

  tags = local.tags
}
