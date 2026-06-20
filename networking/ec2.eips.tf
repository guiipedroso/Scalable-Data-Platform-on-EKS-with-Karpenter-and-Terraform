resource "aws_eip" "this" {
  count  = length(aws_subnet.public)
  domain = "vpc"
  tags = {
    Name = "${var.vpc.name}-${var.vpc.eip_name}-${aws_subnet.public[count.index].availability_zone}"
  }
}