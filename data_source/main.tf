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

# AMI
data "aws_ami" "main" {
  most_recent = true
}

output "ami" {
  value = data.aws_ami.main.id
}

#SG
data "aws_security_group" "main" {
  tags = {
    name ="my-sg"

  }
}
output "sg" {
  value = data.aws_security_group.main.id
}

#VPC
data "aws_vpc" "name" {
tags = {
  Name = "my_vpc"
 }
}

output "vpc" {
  value = data.aws_vpc.name.id
}

data "aws_subnet" "main" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    Name = "public_subnet"
  }
}

output "subnet" {
  value = data.aws_subnet.main.id
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.main.id
  instance_type = "t2.micro"
  subnet_id = data.aws_ami.main.id
  security_groups = [data.aws_security_group.main.id]
  associate_public_ip_address = true
  tags = {
    Name = "ec2"
  }

}

data "aws_caller_identity" "name" {
}
data "aws_region" "name" {
}

output "caller_info" {
  value = data.aws_caller_identity.name
}