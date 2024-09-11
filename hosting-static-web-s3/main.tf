terraform {
  required_providers {
  aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
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

resource "random_id" "rand" {
   byte_length = 8
   }

resource "aws_s3_bucket" "web" {
  bucket = "bucket-my-website-${random_id.rand.hex}"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.web.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style" {
 bucket = aws_s3_bucket.web.bucket
 source = "./styles.css"
 key = "styles.css" 
 content_type = "text/css"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.web.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "web"{
  bucket = aws_s3_bucket.web.bucket
  policy = jsonencode(
   {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "${aws_s3_bucket.web.arn}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.bucket
  index_document {
   suffix = "index.html"

  }
}


output "bucket-endpoint" {
  value = aws_s3_bucket_website_configuration.web.website_endpoint
}