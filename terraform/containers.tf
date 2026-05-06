resource "aws_ecr_repository" "flask_repo" {
  name                 = "ops-blog/flask-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_ecs_cluster" "flask_cluster" {
  name = "ops-blog-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "flask_capacity" {
  cluster_name = aws_ecs_cluster.flask_cluster.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = "FARGATE_SPOT"
  }
}

resource "aws_ecs_task_definition" "flask_app" {
  family = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                = 256
  memory             = 512
  execution_role_arn = aws_iam_role.task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "ops-blog-flask-app"
      image     = "${aws_ecr_repository.flask_repo.repository_url}:${var.ecr_image_tag}"
      logConfiguration = {
      logDriver = "awslogs"
      options = {
          "awslogs-group"         = aws_cloudwatch_log_group.flask_logs.name
          "awslogs-region"        = data.aws_region.current.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
      secrets = [
        {
          name      = "SECRET_KEY"    
          valueFrom = aws_ssm_parameter.flask_secret.arn
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "efs-storage" 
          containerPath = "/usr/local/var/flaskr-instance"
          readOnly      = false
        }
      ]
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])

  volume {
    name = "efs-storage"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.flask_efs.id
      transit_encryption      = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.flask_efs_access.id
        iam             = "ENABLED"
      }
    }
  }
}

resource "time_sleep" "wait_for_DNS" {
  depends_on = [aws_efs_mount_target.flask_efs_mount]

  create_duration = "75s"
}

resource "aws_ecs_service" "flask_service" {
  name            = "flask-service"
  cluster         = aws_ecs_cluster.flask_cluster.id
  task_definition = aws_ecs_task_definition.flask_app.arn
  desired_count   = 1

  depends_on = [time_sleep.wait_for_DNS]

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1 
    base              = 0  
  }

  network_configuration {
    subnets          = [aws_subnet.public_1.id]
    security_groups  = [aws_security_group.flask_sg.id]
    assign_public_ip = true
  }
}


