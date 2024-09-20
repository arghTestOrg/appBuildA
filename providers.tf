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
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

# EKS Cluster Endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

