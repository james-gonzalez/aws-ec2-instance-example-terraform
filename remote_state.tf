terraform {
  backend "s3" {
    bucket = "jamesg-terraform-states"
    key    = "default/ec2-example/terraform.tfstate"
    region = "eu-west-1"
  }
}
