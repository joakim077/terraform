locals {
  message = "Hello world"
}

variable "string_list" {
  type = list(string)
  default = [ "ap-south-1", "us-east-1", "us-east-2", "ap-south-1" ]
}

output "output" {
# value = upper(local.message)
# value = startswith(local.message, "hello") 
# value = split(" ", local.message)
# value = min(1,3,5,78,-2)
# value = max(343,35,22,1000)
# value = abs(-12.12)
# value = length(local.message)
# value = contains(var.string_list, "ap-south-1")
value = toset(var.string_list)
}