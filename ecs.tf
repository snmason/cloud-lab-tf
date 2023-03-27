/// ecs.tf configures all resources related to the ecr instance.

resource "aws_ecs_cluster" "cluster" {
  for_each = { for key, ecs_cluster in var.ecs_cluster : key => ecs_cluster if ecs_cluster.enabled}

  name = each.key
}

// Right now just want to create one of these if the cluster is enabled. 
// TODO rework this so multiple clusters can have it's own provider configured if I choose to use more than 1.
resource "aws_ecs_cluster_capacity_providers" "cluster" {
  count = var.ecs_cluster["JenkinsFargateCluster"].enabled ? 1 : 0

  cluster_name = "JenkinsFargateCluster"

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {

    weight = 100
    base = 1
    capacity_provider = "FARGATE"
  }
}


// Still figuring out how to design my task definition file
# resource "aws_ecs_service" "cluster" {
#   count = aws_ecs_cluster.cluster ? 1 : 0

# }