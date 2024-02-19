terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0" # latest version is 5.37
    }
  }
}
provider "aws" {
    region = "AWS_REGION"
    access_key = "AWS_ID" # Best practce not to type here, use a teraform.tfvars file
    secret_key = "AWS_KEY " # Same
}
