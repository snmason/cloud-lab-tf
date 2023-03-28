/// ecs.tf configures all resources related to the ecr instance.

resource "aws_ecs_cluster" "cluster" {
  for_each = { for key, ecs_cluster in var.ecs_cluster : key => ecs_cluster if ecs_cluster.enabled}

  name = each.key

  configuration {
    execute_command_configuration {
      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.ecs_cluster.name
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "ecs_cluster" {
  name = "ECSLogGroup"
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


// Currently using a sample nginx container for testing before the more complex jenkins.
// Again need to update this to be re-usable
resource "aws_ecs_service" "cluster" {
  count = var.ecs_cluster["JenkinsFargateCluster"].enabled ? 1 : 0

  name = "nginx"
  cluster = aws_ecs_cluster.cluster["JenkinsFargateCluster"].id
  task_definition = file("${path.module}/tasks/nginx.json")
  desired_count = 1

  ordered_placement_strategy {
    type = "binpack"
  }
}