1.simple variable  
    variables.tf
      variable "instance_type" {
          description = "Type of instance"
          default     = "t2.micro"
      }
      
2.ENV_variable    
    export TF_VAR_instance_type="t2.micro"
    export TF_VAR_region="us-west-1"
    
3.terraform.tfvars
      terraform.tfvars
          instance_type = "t2.micro"
          region = "us-west-1"
    
4.*.auto.tfvars   

5.-var & -var-file  
    terraform apply -var="instance_type=t2.micro" -var="region=us-west-1"
    terraform apply -var-file="custom.tfvars" (The custom.tfvars file will have the same format as terraform.tfvars.)


priortiy increase down
