terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

  
resource "aws_instance" "main" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = var.instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_config.v_size
    volume_type           = var.ec2_config.v_type
  }


  tags = merge(var.tags, {
    env = local.env
  })
}

locals {
  env = "dev"
}

