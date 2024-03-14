provider "aws" {
  region = var.REGION
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

}

data "aws_availability_zones" "available" {}

locals {
  Cluster-Name = var.CLUSTER_NAME
}
