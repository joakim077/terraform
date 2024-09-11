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

# 1. Create VPC

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# 2.1 public subnet

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public_subnet"
  }
}

# 2.2 private subnet

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private_subnet"
  }
}

# 3. internet-gateway

resource "aws_internet_gateway" "igw" {

    vpc_id = aws_vpc.main.id
    tags = {
      Name = "my_igw"
    }
}

# 4. Route-table

resource "aws_route_table" "main" {
   
    vpc_id = aws_vpc.main.id
    
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

# 5. route table association

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.main.id
}


