# Credentials are provided through environment variables
# Run those commands to authenticate to AWS
# $ export AWS_ACCESS_KEY_ID="anaccesskey"
# $ export AWS_SECRET_ACCESS_KEY="asecretkey"
# $ export AWS_DEFAULT_REGION="us-west-2"

locals {
  prefix = "clod2021-g5pw"
  # Ubuntu 20.04
  ami_id = "ami-05f7491af5eef733a"
  # Frankfurt
  region = "eu-central-1"
  instance_type = "t2.micro"

  vpc_id = "vpc-0e364be3699101802"
  subnet_id = "subnet-010c9f5d0727a98df"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "webserver" {
  ami_name = "${local.prefix}-siouxsilos"
  ami_description = "WebServer used by 10kloud for SiouxSilos"

  instance_type = local.instance_type
  region = local.region

  vpc_id = local.vpc_id
  subnet_id = local.subnet_id
  associate_public_ip_address = true

  ssh_username = "ubuntu"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
      root-device-type = "ebs"
    }
    owners = ["099720109477"]
    most_recent = true
  }

  tags = {
    Organization = "10kloud"
    Scope = "projectwork"
    Packer = "true"
  }
}

build {
  sources = [
    "source.amazon-ebs.webserver"
  ]

  provisioner "shell" {
    script = "./scripts/nginx.sh"
  }

  provisioner "file" {
    source = "./scripts/siouxsilos.conf"
    destination = "/tmp/default"
  }

  provisioner "shell" {
    script = "./scripts/nginx-apply.sh"
  }

  provisioner "shell" {
    script = "./scripts/nginx-reload.sh"
  }
}