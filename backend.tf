terraform {
  backend "s3" {
    bucket         = "project-2-tf-state-file"
    key            = "3tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}