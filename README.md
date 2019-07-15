# terragrunt-live-control

Voyent's `terragrunt-live-control` is a whiteboxed starter kit designed to be a boilerplate repo that will help you get started managing your infrastructure using terraform/terragrunt. We started with the example docs/repo maintained by the Gruntwork team but found there was still plenty of DRYing up to do.

It is suited for organizations both small and large. Use the patterns we laid out here so you can enjoy a scalable IaC code repository that won't bite you in the butt a few months down the line.

## Before You Get Started

Before using this repo you should already have prerequisite knowledge of both Terraform and Terragrunt. Ideally you have already used Terraform in production and have become familiar with its pitfalls and shortcomings that make it difficult to maintain. Same for Terragrunt, even if it is less prone to these issues.

## Project Goals

  1. Stay up to date with Terragrunt's design patterns in [terragrunt-infrastructure-live-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example)
  1. Have examples of how to create a complicated, multi-tier infrastructure while keeping the code DRY
  1. Provide guidance on how to pass in configuration data
  1. Keep the repo updated with solutions to problems that have caused us grief, as much as possible
  1. Resist temptation to create "wrapper scripts" or any other layers of abstraction. Terragrunt is already enough of a wrapper.

#### Conventions (aka lessons learned from years of experience)

In addition to Terraform and Terragrunt best practices:

  1. Stay DRY and be obsessive about it. No exceptions.
  1. No custom wrapper scripts or other layers of abstraction
  1. `modules/` directory only contains Terraform code
  1. `live/` directory contains Terragrunt code, and the configuration data that gets fed into the actual Terraform code in `modules/`
  1. All user-defined configuration data is defined inside the `live/<env>/terragrunt.hcl` of the stack you are creating. Avoid using `terraform.tfvars`, or any other method
  1. All variable configuration data that is shared between modules is done with AWS's SSM Parameter Store. Do not use `data.terraform_remote_state`, or `outputs {}`, or anything else. An example of this would be: The VPC module needs to share subnet-id with an RDS module.
  1. Don't break the rules

## Installation

  1. Install [terraform](https://www.terraform.io) (We recommend using [tfenv](https://github.com/tfutils/tfenv))
    * `brew install tfenv && tfenv install latest`
  1. Install (terragrunt)[https://github.com/gruntwork-io/terragrunt]
    * `brew install terragrunt`
  1. Install `awscli` and configure it with your API keys
    * `brew install awscli`
    * `aws configure`
  1. Clone this repo

## Usage

##### 1. Remote State

Here's how we deal with the chicken/egg problem of configuration Terraform's Remote State

  1. ```cp terraform/config/remote_state.config.example terraform/config/remote_state.config```
  1. Edit `remote_state.config` to your needs
  1. ```cd terraform/live/global/terraform-remote-state```
  1. ```terragrunt apply```

Now we are ready to create infrastructure.

##### 2. Launch example infrastructure

This repo comes equipped an example of how you can launch a VPC, MySQL RDS, and webserver running on an EC2 Instance.

  1. ```cd terraform/live/stg```
  1. ```terragrunt apply-all```
  1. Done!

##### 3. Adding to the infrastructure configuration
  
If you have an App Stack you want to add:

  1. Create `modules/myappstack` and define all of your Terraform code, or better yet just pull in a module from [Terraform Module Registry](https://registry.terraform.io/)
  1. Following examples provided in this repo, create `live/{stg,prod}/myappstack/terragrunt.hcl` that calls the module from step 1.
  1. `terragrunt apply`, that's it!

## Requirements

  1. Terraform 0.12.4+
  1. terragrunt v0.19.8+
  1. AWS, this repo doesn't support any other IaaS provider at this time

