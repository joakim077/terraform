output "vpc_name" {
  value = aws_vpc.main.tags.Name
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet" {
  value = aws_subnet.public.tags.Name
}

output "private_subnet" {
  value = aws_subnet.private.tags.Name
}

output "igw_name" {
  value = aws_internet_gateway.igw.tags.Name
}

