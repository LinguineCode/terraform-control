remote_state {
  #Tip: "Variables not allowed; Variables may not be used here."
  backend = "s3"

  config = {
    bucket         = chomp(run_cmd("${path_relative_from_include()}/../config/config.sh", "BUCKET"))
    region         = chomp(run_cmd("${path_relative_from_include()}/../config/config.sh", "REGION"))
    dynamodb_table = chomp(run_cmd("${path_relative_from_include()}/../config/config.sh", "DYNAMODB_TABLE"))
    key            = "${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
  }
}

terraform {
  extra_arguments "env_vars" {
    commands = [
      "init",
      "apply",
      "destroy",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]

    env_vars = {
      TF_VAR_tfmodule = "${element(split("/", path_relative_to_include()), 1)}"
      TF_VAR_env      = "${element(split("/", path_relative_to_include()), 0)}"
    }
  }
}
