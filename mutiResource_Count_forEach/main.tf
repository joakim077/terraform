provider "aws" {
 region = "ap-south-1"
}

locals {
  project = "project01"
}

#Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

# TWO subnets

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# ######## 4 EC2 identical in 2 Subnet

# resource "aws_instance" "ec2" {
#   count = 4
#   ami = "ami-025fe52e1f2dc5044"
#   instance_type = "t2.micro" 
# # subnet_id = aws_subnet.subnet[count.index % length(aws_subnet.subnet)].id
#   subnet_id = element(aws_subnet.subnet[*].id, count.index % length(aws_subnet.subnet))
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }

#####
# X EC2 in two Subnet  different AMI , X: no of EC2 in config
# resource "aws_instance" "name" {
#   count = length(var.ec2_config)
#   ami = var.ec2_config[count.index].ami
#   instance_type = var.ec2_config[count.index].instance_type
#   subnet_id = element(aws_subnet.subnet[*].id, count.index % length(aws_subnet.subnet))
#   tags = {
#       Name = "${local.project}-instance-${count.index}"
#   }
# }

############
# 2 EC2 in diff Subnets (using for_each)

resource "aws_instance" "name" {
  for_each = var.ec2_map
  ami = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.subnet[*].id, index(keys(var.ec2_map),each.key) % length(aws_subnet.subnet))
  tags = {
      Name = "${local.project}-instance-${each.key}"
  }
}
