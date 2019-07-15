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
