module "vpc" {
  source          = "git::https://github.com/solsglasses/terraform-aws-vpc?ref=terraform12"
  name_tag_prefix = "${var.tfmodule}-${var.env}"
}

resource "aws_ssm_parameter" "vpc_id" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/vpc_id"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "default_security_group_id" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/default_security_group_id"
  value = module.vpc.default_security_group_id
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/private_subnet_ids"
  value = join(",", module.vpc.private_subnet_ids["private"])
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/public_subnet_ids"
  value = join(",", module.vpc.public_subnet_ids["public"])
}
