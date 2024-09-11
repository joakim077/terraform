terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
  backend "s3" {
    bucket = "backend-bucket-tf-state"
    key = "backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "main" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"

  tags = {
    name = "EC2-Server"
  }
}