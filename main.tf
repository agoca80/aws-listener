resource "aws_security_group_rule" "this" {
  from_port                = var.port
  protocol                 = "tcp"
  to_port                  = var.port
  type                     = "ingress"
  security_group_id        = data.aws_security_group.this.id
  source_security_group_id = local.sg_id
}

resource "aws_alb_listener_rule" "this" {
  listener_arn = local.listener_arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = data.aws_alb_target_group.this.arn
  }

  condition {
    host_header {
      values = [local.fqdn]
    }
  }

  tags = local.tags
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_ssm_parameter.zone_id.value
  name    = var.name
  type    = "A"

  alias {
    name                   = local.alb_name
    zone_id                = local.alb_zone_id
    evaluate_target_health = true
  }
}
