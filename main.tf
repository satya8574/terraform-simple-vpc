####### vpc ######################
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name"    = "myvpc"
    "Project" = "ALd Automobile"
  }
}
########### Internet gateway ##########
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name"   = "internetGateway"
    "Attach" = "myvpc"
  }
}
######### subnet ########################
resource "aws_subnet" "mysubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name"             = "public_subnet-1"
    "Availabilty Zone" = "us-east-1a"
  }
}
######### Route Table ###################
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route = []
  tags = {
    "Name"       = "internetRT"
    "associated" = "mysubnet"
  }
}
########## route #######################
resource "aws_route" "route" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.rt]
}
########## route table association ######
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.rt.id
}
############# security group #############
resource "aws_security_group" "sg" {
  name        = "allow_all_traffic"
  description = "allow all inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress = [
    {
      description = "all traffic"
      cidr_blocks = ["0.0.0.0/0"]

      from_port        = 0 # all ports
      to_port          = 0
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "-1" #all traffic
      security_groups  = null
      self             = null
    }
  ]
  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "outbound rule"
      prefix_list_ids  = null
      self             = false
      security_groups  = null
      self             = null
    }
  ]
  tags = {
    Name = "All traffic"
  }
}
############### EC2 INSTANCE ###############
# resource "aws_instance" "ec2-1" {
#   ami = "ami-05fa00d4c63e32376"
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.mysubnet.id
#   key_name = "dev"
#   tags = {
#     "Name" = "Machine-1"
#     "os_types" = "Linux_ubuntu"
#     "Env" ="Development"
#     "project" ="veloce"
#   }
# }








































