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

