resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"

  tags = {
    Name = "ecs-cluster"
  }
}
