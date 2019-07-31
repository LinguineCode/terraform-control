remote_state {
  #Tip: "Variables not allowed; Variables may not be used here."
  backend = "s3"

  config = {
    bucket         = chomp(run_cmd("${path_relative_from_include()}/../scripts/config.sh", "BUCKET"))
    region         = chomp(run_cmd("${path_relative_from_include()}/../scripts/config.sh", "REGION"))
    dynamodb_table = chomp(run_cmd("${path_relative_from_include()}/../scripts/config.sh", "DYNAMODB_TABLE"))
    key            = "${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
  }
}

terraform {
  after_hook "init_from_module" {
    commands = ["init-from-module"]
    execute  = ["cp ${get_parent_terragrunt_dir()}/backend.tf", "${get_terragrunt_dir()/"}"
  }

  after_hook "delete_after_succesfull_apply" {
    commands = ["apply"]
    execut   = ["rm", "${get_terragrunt_dir}/backend.tf"]
  }

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
