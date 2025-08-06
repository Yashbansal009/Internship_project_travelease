# Terraform configuration for booking-service
provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "booking" {
  name = "travelease1/booking"
}

resource "aws_ecs_cluster" "booking_cluster" {
  name = "booking-service-cluster"
}

resource "aws_security_group" "booking_sg" {
  name        = "booking-service-sg"
  vpc_id      = "vpc-0bc652bfc089f9e1a"
  ingress {
    from_port   = 8080      # <-- Use your app's port
    to_port     = 8080      # <-- Use your app's port
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
  name = "ecsTaskExecutionRole-booking"
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

resource "aws_ecs_task_definition" "booking_task" {
  family                   = "booking-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "booking"
      image     = "726661503021.dkr.ecr.ap-south-1.amazonaws.com/travelease1/booking:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080     # <-- Use your app's port
          hostPort      = 8080     # <-- Use your app's port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/booking"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "booking_service" {
  name            = "booking-service"
  cluster         = aws_ecs_cluster.booking_cluster.id
  task_definition = aws_ecs_task_definition.booking_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = ["subnet-04aad417a5be11f7e"] # <-- Your actual Subnet ID(s)
    security_groups = [aws_security_group.booking_sg.id]
    assign_public_ip = true
  }
}

# (Optional) Add Load Balancer resources if you want public access and health checks

# REQUIRED: Fill in <your_vpc_id>, <your_subnet_id_1>, <your_subnet_id_2>, <your_aws_account_id>
