provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_s3_bucket" "default" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name = var.s3_bucket_name
  }
}

resource "aws_instance" "test" {
  for_each               = local.instances
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = aws_subnet.test.*.id[0]
  iam_instance_profile   = aws_iam_instance_profile.default.name

  key_name = aws_key_pair.default.key_name
  tags = {
    Name = data.aws_ami.ubuntu.id
  }
}
