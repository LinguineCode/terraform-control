data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ssm_parameter" "vpc_id" {
  name = "${var.ssm_path_prefix_vpc}-${var.env}/vpc_id"
}
data "aws_ssm_parameter" "default_security_group_id" {
  name = "${var.ssm_path_prefix_vpc}-${var.env}/default_security_group_id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "${var.ssm_path_prefix_vpc}-${var.env}/private_subnet_ids"
}
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "${var.ssm_path_prefix_vpc}-${var.env}/public_subnet_ids"
}


data "aws_ssm_parameter" "db_address" {
  name = "${var.ssm_path_prefix_db}-${var.env}/db_address"
}
data "aws_ssm_parameter" "db_name" {
  name = "${var.ssm_path_prefix_db}-${var.env}/db_name"
}
data "aws_ssm_parameter" "db_password" {
  name = "${var.ssm_path_prefix_db}-${var.env}/db_password"
}
data "aws_ssm_parameter" "db_username" {
  name = "${var.ssm_path_prefix_db}-${var.env}/db_username"
}

data "aws_ssm_parameter" "db_port" {
  name = "${var.ssm_path_prefix_db}-${var.env}/db_port"
}
