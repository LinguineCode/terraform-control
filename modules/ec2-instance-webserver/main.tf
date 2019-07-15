resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = var.instance_type

  vpc_security_group_ids = split(",", data.aws_ssm_parameter.default_security_group_id.value)
  subnet_id              = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)
  user_data              = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export DB_ADDRESS=${data.aws_ssm_parameter.db_address.value}
export DB_NAME=${data.aws_ssm_parameter.db_name.value}
export DB_PASSWORD=${data.aws_ssm_parameter.db_password.value}
export DB_USERNAME=${data.aws_ssm_parameter.db_username.value}
export DB_PORT=${data.aws_ssm_parameter.db_port.value}
echo "Hello World" | sudo tee /var/www/html/index.html
EOF

  tags = {
    Name = "${var.tfmodule}-${var.env}"
  }
}
