data "aws_ssm_parameter" "vpc_id" {
  name = format("/environment/%s/vpc_id", var.environment)
}

data "aws_security_group" "this" {
  name   = var.name
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  tags = {
    Environment = var.environment
  }
}

data "aws_alb" "this" {
  name = var.name

  tags = {
    Name        = var.name
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
