terraform {
  backend "s3" {
    bucket = "jamesg-terraform-states"
    key    = "default/testing-setup/terraform.tfstate"
    region = "eu-west-1"
  }
}
