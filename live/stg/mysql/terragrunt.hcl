include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/mysql"
}

inputs = {
  ssm_path_prefix_vpc = "/base-networking"

  multi_az                = false
  db_name                 = "mydatabase"
  db_username             = "myusername"
  db_port                 = 3306
  db_engine               = "mysql"
  db_engine_version       = "5.7.19"
  db_instance_class       = "db.t2.large"
  db_allocated_storage    = 512
  db_storage_encrypted    = true
  db_major_engine_version = "5.7"
  db_family               = "mysql5.7"
  db_maintenance_window   = "Mon:00:00-Mon:03:00"
  db_backup_window        = "03:00-06:00"
}

dependencies {
  paths = ["../base-networking"]
}
