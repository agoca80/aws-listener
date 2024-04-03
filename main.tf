resource "aws_security_group_rule" "this" {
  from_port                = var.port
  protocol                 = "tcp"
  to_port                  = var.port
  type                     = "ingress"
  security_group_id        = data.aws_security_group.this.id
  source_security_group_id = var.sg.id
}

resource "aws_alb_listener_rule" "this" {
  listener_arn = var.listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = data.aws_alb_target_group.this.arn
  }

  condition {
    host_header {
      values = [format("%s.%s", var.name, var.zone.name)]
    }
  }

  tags = local.tags
}

resource "aws_route53_record" "this" {
  zone_id = var.zone.id
  name    = var.name
  type    = "A"

  alias {
    name                   = var.alb.dns_name
    zone_id                = var.alb.zone_id
    evaluate_target_health = true
  }
}
