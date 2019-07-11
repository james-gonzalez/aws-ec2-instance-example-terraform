variable "s3_bucket_name" {
  default = "jg-test-bucket"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

variable "ingress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "egress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}