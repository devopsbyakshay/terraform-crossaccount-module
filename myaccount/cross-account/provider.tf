terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
  profile = "my-first-account"
}

provider "aws" {
  region  = "ap-south-1"
  profile = "my-second-account"
  alias   = "my-second-account"
}