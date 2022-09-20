# output "vpc_name" {
#   value = aws_vpc.myvpc.name
# }
# output "vpc_id" {
#   value = aws_vpc.myvpc.vpc_id
# }

# output "subnet_id" {
#   value = aws_subnet.mysubnet.subnet_name
# }
output "public_subnet_cidr" {
  value = aws_subnet.mysubnet.cidr_block
}