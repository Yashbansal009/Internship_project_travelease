# Terraform configuration for user-service

provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "user" {
  name = "travelease1/user"
}

resource "aws_ecs_cluster" "user_cluster" {
  name = "user-service-cluster"
}

resource "aws_security_group" "user_sg" {
  name        = "user-service-sg"
  vpc_id      = "vpc-0bc652bfc089f9e1a"                
  ingress {
    from_port   = 8080                        
    to_port     = 8080                        
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-user"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "user_task" {
  family                   = "user-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "user"
      image     = "726661503021.dkr.ecr.ap-south-1.amazonaws.com/travelease1/user:latest" 
      essential = true
      portMappings = [
        {
          containerPort = 8080                      
          hostPort      = 8080                     
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/user"       
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "user_service" {
  name            = "user-service"
  cluster         = aws_ecs_cluster.user_cluster.id
  task_definition = aws_ecs_task_definition.user_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = ["subnet-04aad417a5be11f7e"] 
    security_groups = [aws_security_group.user_sg.id]
    assign_public_ip = true
  }
}

