/// Configures VPC that is used by admin environment.

module "vpc" {
  for_each = { for key, vpc in var.vpc : key => vpc if vpc.enabled }
  source = "terraform-aws-modules/vpc/aws"

  name = each.key

  cidr = each.value.cidr

  // This is incorrect
  azs = each.value.azs
  public_subnets = each.value.subnet_cidr.public
  private_subnets = each.value.subnet_cidr.private

  single_nat_gateway = each.value.single_nat_gateway



  tags = local.tags
}


