data "aws_security_group" "this" {
  name   = var.name
  vpc_id = var.vpc.id

  tags = {
    Environment = var.environment
  }
}

data "aws_alb_target_group" "this" {
  name = var.name

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}
