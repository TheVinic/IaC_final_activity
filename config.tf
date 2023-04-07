terraform {
  backend "s3" {
    bucket = "terraform-state-files"
    key    = "terraform/terraform.tfstate"
    region = "us-east-2"
  }
}