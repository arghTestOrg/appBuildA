terraform {
  required_version = ">= 1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.65"
    }
  }

  backend "s3" {
    bucket = "oidc-tf-state-bucket"
    key    = "terraform/state"
    region = "ap-southeast-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.65"
    }
  }
}
