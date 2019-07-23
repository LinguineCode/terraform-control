include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2-instance-webserver"
}

inputs = {
  ssm_path_prefix_vpc = "/base-networking"
  ssm_path_prefix_db  = "/mysql"

  instance_type = "t2.micro"
}

dependencies {
  paths = ["../base-networking", "../mysql", ]
}
