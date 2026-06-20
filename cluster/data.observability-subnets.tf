data "aws_subnets" "observability" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Purpose"
    values = ["observability"]
  }
}
