terraform {
  required_version = ">= 1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.65"
    }
  }
}

data "terraform_remote_state" "s3state" {
  backend = "s3"
  config = {
    bucket = "oidc-tf-state-bucket"
    key    = "terraform/state"
    region = "ap-southeast-1"
    encrypt = true 
  }
}

