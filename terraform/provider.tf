provider "aws" {}

terraform {
  backend "s3" {
    bucket = "node-proj"
    key    = "stack/terraform.tfstate"
    region = "us-east-2"
  }
}
