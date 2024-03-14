module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.PROJECT_NAME
  cidr = var.CIDR

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = [var.PUB-SUB-1-CIDR, var.PUB-SUB-2-CIDR, var.PUB-SUB-3-CIDR]
  public_subnets  = [var.PRIV-SUB-1-CIDR, var.PRIV-SUB-2-CIDR, var.PRIV-SUB-3-CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.Cluster-Name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.Cluster-Name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
