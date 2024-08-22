# I chose AWS because I trained on it
provider "aws" {
  region = "eu-central-1"
}

variable "cluster_name" {
  default = "demo"
}

variable "cluster_version" {
  default = "1.22"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
