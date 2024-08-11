output "ip" {
  value = aws_instance.main.public_ip
}

output "url" {
  value = "http://${aws_instance.main.public_ip}"
}