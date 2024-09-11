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

resource "random_id" "random" {
  byte_length = 8
}

resource "aws_s3_bucket" "main" {
  bucket = "terraform-bucket-${random_id.random.hex}"
}

resource "aws_s3_object" "main" {
  bucket = aws_s3_bucket.main.id
  source = "./file.txt"
  key = "file.txt"
}

output "bucket-name" {
  value = aws_s3_bucket.main.id
}