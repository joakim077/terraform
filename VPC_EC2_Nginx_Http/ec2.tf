resource "aws_instance" "main" {
  subnet_id = aws_subnet.public.id
  ami = "ami-0ad21ae1d0696ad58"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.main.id]
  associate_public_ip_address = true
  tags = {
    Name = "my-nginx-server"
  }

  user_data = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install nginx -y
        sudo systemctl start nginx
        EOF
}