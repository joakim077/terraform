variable "ec2_name" {
  default = "variable.tf"
}


variable "instance_type" {
    description = "Enter the instance type"
    type = string
    validation {
      condition = var.instance_type == "t2.micro" || var.instance_type == "t3.micro" 
      error_message = "only t2.micro and t3.micro are allowed"
    }
    default = "t2.micro"
}

variable "ec2_config" {
  type = object({
    v_size = number
    v_type = string
  })
  default = {
    v_size = 20
    v_type = "gp2"
  }
}

variable "tags" {
  type = map(string)
  default = {}
  
}