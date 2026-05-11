resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true 
  enable_dns_hostnames = true 

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.subnet_az 

  tags = {
    Name = "public_1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "flask_sg" {
  name        = "ops-blog-sg"
  description = "Restrict access to ECS task"
  vpc_id      = aws_vpc.main.id

  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.flask_sg.id
  cidr_ipv4         = "${var.allowed_ips}/32"
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_to_efs" {
  security_group_id = aws_security_group.flask_sg.id
  referenced_security_group_id = aws_security_group.flask_efs_sg.id
  from_port         = 2049
  ip_protocol       = "tcp"
  to_port           = 2049
}

