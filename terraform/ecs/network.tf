module "network" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  
  name = "ecs-vpc"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  azs             = ["eu-north-1a", "eu-north-1b"] # ,"eu-north-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"] # ,"10.0.3.0/24"]
  public_subnets  = ["10.0.0.0/26", "10.0.0.64/26"] # ,"10.0.0.128/26"]

  enable_nat_gateway = true
  single_nat_gateway = false
  enable_vpn_gateway = false

  tags = local.tags
}
