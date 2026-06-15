data "aws_acm_certificate" "my_cert" {
  domain   = "opsblog.site"     
  types    = ["IMPORTED"]
  key_types = ["RSA_4096"]
}

resource "aws_security_group" "alb_sg" {
  name        = "ops-blog-sg-alb"
  description = "SG for ALB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "efs_outbound" {
  security_group_id = aws_security_group.alb_sg.id
  referenced_security_group_id = aws_security_group.flask_sg.id
  from_port         = 5000
  to_port           = 5000
  ip_protocol       = "tcp"
}

resource "aws_lb" "alb" {
  count              = var.environment_active ? 1 : 0
  name               = "ops-blog-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  drop_invalid_header_fields = true

  tags = {
    Project = "Ops-Blog"
  }
}

resource "aws_lb_target_group" "flask_tg" {
  count       = var.environment_active ? 1 : 0
  name_prefix = "ops-"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"  

  health_check {
    enabled             = true
    path                = "/"
    port                = "5000"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Project = "Ops-Blog"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http" {
  count             = var.environment_active ? 1 : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = var.environment_active ? 1 : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"  # Modern TLS
  certificate_arn   = data.aws_acm_certificate.my_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_tg[0].arn
  }
}

