locals {
  alb_name     = var.ingress.alb.dns_name
  alb_zone_id  = var.ingress.alb.zone_id
  listener_arn = var.ingress.listener.arn
  sg_id        = var.ingress.sg.id

  fqdn = format("%s.%s", var.name, data.aws_ssm_parameter.zone_name.value)

  tags = {
    Name   = var.name
    Module = "listener"
  }
}
