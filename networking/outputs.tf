output "vpc_id" {
  value = aws_vpc.this.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "public_subnets_ids" {
  value = aws_subnet.public[*].id
}

output "public_route_table_associations_ids" {
  value = aws_route_table_association.public[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.this[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private[*].id
}

output "private_route_table_ids" {
  value = aws_route_table.private[*].id
}

output "private_route_table_associations_ids" {
  value = aws_route_table_association.private[*].id
}

output "observability_subnets_ids" {
  value = aws_subnet.observability[*].id
}