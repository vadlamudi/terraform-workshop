# S3 backend example 
# see https://www.terraform.io/docs/backends/types/s3.html

terraform {
  backend "s3" {
    bucket = "dws-di-roxymusic"
    key    = "state/remote-state"
	region = "us-east-2"
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "TestInstance"
  }
}
