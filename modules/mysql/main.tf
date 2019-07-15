module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "v2.2.0"

  identifier           = "${var.tfmodule}-${var.env}"
  multi_az             = var.multi_az
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  storage_encrypted    = var.db_storage_encrypted
  major_engine_version = var.db_major_engine_version
  family               = var.db_family

  maintenance_window = var.db_maintenance_window
  backup_window      = var.db_backup_window

  name     = var.db_name
  username = var.db_username
  port     = var.db_port
  password = random_string.main.result

  vpc_security_group_ids = split(",", data.aws_ssm_parameter.default_security_group_id.value)
  subnet_ids             = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

}

resource "random_string" "main" {
  length  = 16
  special = true
}

resource "aws_ssm_parameter" "db_address" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/db_address"
  value = "${module.rds.this_db_instance_address}"
}
resource "aws_ssm_parameter" "db_name" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/db_name"
  value = "${module.rds.this_db_instance_name}"
}
resource "aws_ssm_parameter" "db_password" {
  type  = "SecureString"
  name  = "/${var.tfmodule}-${var.env}/db_password"
  value = "${module.rds.this_db_instance_password}"
}
resource "aws_ssm_parameter" "db_username" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/db_username"
  value = "${module.rds.this_db_instance_username}"
}
resource "aws_ssm_parameter" "db_port" {
  type  = "String"
  name  = "/${var.tfmodule}-${var.env}/db_port"
  value = "${module.rds.this_db_instance_port}"
}
