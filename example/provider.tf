terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
  profile = "terraform"
  shared_credentials_files = ["../.aws/credentials"]
}
