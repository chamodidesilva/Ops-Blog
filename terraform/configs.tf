resource "aws_ssm_parameter" "flask_secret" {
  name  = "/ops-blog/FLASK_SECRET"
  type  = "String"
  value = var.flask_secret_value 
}

resource "aws_iam_role" "task_execution_role" {
  name = "ops-blog-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "parameter_access_policy" {
  name = "ops-blog-parameter-access-policy"
  role = aws_iam_role.task_execution_role.name

  policy = jsonencode({
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeParameters"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": aws_ssm_parameter.flask_secret.arn
        }
    ]
})
}

# for EFS access 
resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name = "ops-blog-ecs-inline-policy"
  role = aws_iam_role.ecs_task_role.name

  policy = jsonencode({
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientRootAccess"
            ],
            "Resource": aws_efs_file_system.flask_efs.arn
            Condition = {
              StringEquals = {
                "elasticfilesystem:AccessPointArn" = aws_efs_access_point.flask_efs_access.arn
              }
            }
        }
    ]
})
} 

resource "aws_iam_role" "ecs_task_role" {
  name = "ops-blog-ecs-task-role"

  assume_role_policy = jsonencode({
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Principal":{
            "Service":[
               "ecs-tasks.amazonaws.com"
            ]
         },
         "Action":"sts:AssumeRole",
         "Condition":{
            "ArnLike":{
            "aws:SourceArn":"arn:aws:ecs:${var.region}:${var.acc_id}:*"
            },
            "StringEquals":{
               "aws:SourceAccount":"${var.acc_id}"
            }
         }
      }
   ]
})
}

resource "aws_cloudwatch_log_group" "flask_logs" {
  name = "/ecs/ops-blog"
  retention_in_days = 1
  log_group_class = "INFREQUENT_ACCESS"

  tags = {
    Project = "Ops-Blog"
  }
}

