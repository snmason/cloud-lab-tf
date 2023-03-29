# terraform.tfvars specifies the desired configuration of the admin environment.

vpc = {
  CloudLabVPC = {
    enabled = true
    cidr = "10.0.0.0/16"
    azs = ["us-west-1a", "us-west-1b"]
    subnet_cidr = {
      # private = ["10.0.1.0/24"]
      private = []
      public = ["10.0.101.0/24"]
    }
    single_nat_gateway = true
  }
}

ecs_cluster = {
  JenkinsFargateCluster = {
    enabled = true
  }
}