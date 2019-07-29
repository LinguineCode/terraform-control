# terraform-control

[terraform-control](https://github.com/solsglasses/terraform-control) is a boilerplate starter kit repo that will help you succeed in managing your infrastructure using [Terraform](https://www.terraform.io) with [Terragrunt](https://github.com/gruntwork-io/terragrunt). We started with the [example docs/repo maintained by the Gruntwork team](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example) but found there were still plenty of improvements to make.

Terraform and Terragrunt are both very powerful and extensible tools that offer an overwhelming amount of options on how to structure your repo. Use the patterns we laid out here so you can enjoy a scalable IaC code repository that won't bite you in the butt a few months down the line.

## Before You Get Started

Prior to using this repo you should already have prerequisite knowledge of both Terraform and Terragrunt. Ideally you have already used Terraform in production and have become familiar with its pitfalls and shortcomings that make it difficult to maintain. Same for Terragrunt, even if it is less prone to these issues.

## Project Goals

  1. [**K**eep **I**t **S**imple, **S**tupid](https://en.wikipedia.org/wiki/KISS_principle). STAND UP! to your inner voice that is telling you that have a snowflake situation, and to bungle your whole infrastructure with bespoke scripts that only you can understand. Ask yourself instead, "Why do I feel empty inside all the time?"
  1. Stay up to date with Terragrunt's design patterns in [terragrunt-infrastructure-live-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example)
  1. Be suited for organizations both small and large
  1. Have examples of how to create a complicated, multi-tier infrastructure while keeping the code DRY
  1. Provide guidance on how to pass in configuration data
  1. Keep the repo updated with solutions to problems that have caused us grief in the past
  1. Resist temptation to create "wrapper scripts" or any other layers of abstraction

## Project Conventions

![Rules](https://imgur.com/zV5Uavn.gif)

In addition to Terraform and Terragrunt best practices:

  1. Stay DRY and be obsessive about it. No exceptions.
  1. No custom wrapper scripts or other layers of abstraction. Terragrunt is already enough of a wrapper.
  1. `modules/` directory only contains Terraform code and all variable data is set as a `variable {}`
  1. `live/` directory contains Terragrunt code with the configuration data (`inputs {}`) that gets fed into the actual Terraform code in `modules/`
  1. Limit the origin of configuration data to only one single source per each _type_ of configuration data. We have three (3) possible _types_ of configuration data. [See section on Sources of Configuration Data](#sources-of-configuration-data) for further explanation

### Sources of Configuration Data

#### "_User-defined_" Configuration Data

_User-defined Configuration_ is when a human defines a customizable variable. _Examples: the instance-type of their EC2 instance, the number of instances in an ASG, setting an RDS instance Multi-AZ, etc._

  1. All user-defined configuration data is declared inside the `live/<env>/terragrunt.hcl` of the stack you are creating
  1. Avoid using `terraform.tfvars`, or `$ENVVAR`s, or any other method

#### "_Discovered_" Configuration Data

_Discovered Configuration Data_ are attributes of resources that Terraform has created. _Examples: The VPC module needs to share `subnet-id` data with an RDS module, the RDS module needs to share its `endpoint` with the App module, etc._

  1. All variable configuration data that is shared between modules is done with [AWS's SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html).
      * This has the added benefit of being able to share data with 3rd party tools outside of Terraform (e.g. SAM, serverless-framework)
  1. Do not use `data.terraform_remote_state`, or `outputs {}`, or any other method. 

#### "_Remote State_" Configuration Data

_Remote State Configuration Data_ is the information on the S3 bucket and DynamoDB table to use for your `backend.config.{}`.

  1. Remote state configuration data is declared inside the file `config/remote_state.config`
  1. Avoid hard coding the backend configuration

## Installation

See each vendor's documentation for detailed installation docs. Below is a TL;DR for OSX people.

  1. Install [terraform](https://www.terraform.io) (We recommend using [tfenv](https://github.com/tfutils/tfenv))
      * `brew install tfenv && tfenv install latest`
  1. Install [terragrunt](https://github.com/gruntwork-io/terragrunt)
      * `brew install terragrunt`
  1. Install `awscli` and configure it with your API keys
      * `brew install awscli`
      * `aws configure`
  1. Clone this repo

## Usage

##### 1. Set Up Terraform Remote State (The Chicken/Egg Problem)

This is the only "stack" where we are forced to break just two rules: #1 - Use the `local` backend with no remote locking. Commit the local state db into the git repo. #2 - Use wrapper process to populate the `backend.config.{}`.

  1. ```cp terraform/config/remote_state.config.example terraform/config/remote_state.config```
  1. Edit `remote_state.config` to your needs
  1. ```cd terraform/live/global/terraform-remote-state```
  1. ```terragrunt apply```

Now we are ready to create infrastructure.

##### 2. Launch example infrastructure

This repo comes equipped an example of how you can launch a a webserver running on an EC2 Instance, and dependencies of a VPC and RDS MySQL instance.

  1. ```cd terraform/live/stg```
  1. ```terragrunt apply-all```
  1. Done! :tada: Have a look around, and then:
  1. ```terragrunt destroy-all```

##### 3. Adding your own infrastructure configuration
  
If you have an App Stack you want to add:

  1. Create `modules/myappstack` and define all of your Terraform code, or better yet just pull in a module from [Terraform Module Registry](https://registry.terraform.io/)
  1. Following examples provided in this repo, create new `live/{stg,prod}/myappstack/terragrunt.hcl` that calls the module from step 1.
  1. `terragrunt apply`
  1. Done! :tada: 

![Celebrate](https://media.giphy.com/media/6oMKugqovQnjW/giphy.gif)

## Requirements

  1. AWS, this repo doesn't support any other IaaS provider at this time
  1. Terraform 0.12.4+
  1. Terragrunt v0.19.8+

## To-Do

  1. [ ] Support for Terraform Cloud Remote State (waiting on https://github.com/gruntwork-io/terragrunt/issues/779)
  1. [ ] Examples for AWS Organizations/Multiple Accounts (see here https://github.com/gruntwork-io/terragrunt-infrastructure-live-example#how-is-the-code-in-this-repo-organized)

## Contributing

We welcome any and all contributions. Please create an Issue or a PR.

## License

See [LICENSE.md](LICENSE.md)