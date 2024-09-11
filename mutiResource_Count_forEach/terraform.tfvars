ec2_config = [ {
  ami = "ami-0ad21ae1d0696ad58"  # ubuntu
  instance_type = "t2.micro"
},{
    ami = "ami-025fe52e1f2dc5044" #amazon linux
    instance_type = "t2.micro"
}
 ]


 ec2_map = {
   "ubuntu" = {
     ami = "ami-0ad21ae1d0696ad58"
     instance_type = "t2.micro"
   },
   "amazon" = {
    ami = "ami-025fe52e1f2dc5044"
    instance_type = "t2.micro"
   }
 }