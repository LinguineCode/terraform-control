terraform {
  source = "../../../modules/terraform-remote-state-s3-dynamodb"
}

inputs = {
  bucket         = chomp(run_cmd("../../../config/config.sh", "BUCKET"))
  dynamodb_table = chomp(run_cmd("../../../config/config.sh", "DYNAMODB_TABLE"))
}
