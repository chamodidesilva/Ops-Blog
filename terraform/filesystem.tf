resource "aws_efs_file_system" "flask_efs" {
  creation_token = "ops-blog-efs"
  # one zone EFS
  availability_zone_name = var.subnet_az
  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_efs_mount_target" "flask_efs_mount" {
  file_system_id = aws_efs_file_system.flask_efs.id
  subnet_id      = aws_subnet.public_1.id
  security_groups = [aws_security_group.flask_efs_sg.id]
}

resource "aws_efs_access_point" "flask_efs_access" {
  file_system_id = aws_efs_file_system.flask_efs.id

  # matches user specified in the Dockerfile
  posix_user {
    uid = 1000
    gid = 1000 
  }
  
  # maps to mountPath in the container definition
  root_directory {
    path = "/flaskr-data"
    creation_info {
      owner_uid   = 1000
      owner_gid   = 1000
      permissions = "755"
    }
  }
}

resource "aws_security_group" "flask_efs_sg" {
  name        = "ops-blog-efs-sg"
  description = "Security group for EFS mount target"
  vpc_id      = aws_vpc.main.id

  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ecs" {
  security_group_id = aws_security_group.flask_efs_sg.id
  referenced_security_group_id = aws_security_group.flask_sg.id
  from_port         = 2049
  ip_protocol       = "tcp"
  to_port           = 2049
}

