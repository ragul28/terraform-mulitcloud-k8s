data "aws_vpc_endpoint_service" "this" {
  for_each = var.vpc_endpoints

  service = try(each.value.service, null)

  filter {
    name   = "service-type"
    values = [try(each.value.service_type, "Interface")]
  }
}

resource "aws_vpc_endpoint" "this" {
  for_each = var.vpc_endpoints

  vpc_id            = aws_vpc.main.id
  service_name      = data.aws_vpc_endpoint_service.this[each.key].service_name
  vpc_endpoint_type = try(each.value.service_type, "Interface")
  auto_accept       = try(each.value.auto_accept, null)

  security_group_ids  = try(each.value.service_type, "Interface") == "Interface" ? [aws_security_group.this.id] : null
  subnet_ids          = try(each.value.service_type, "Interface") == "Interface" ? [aws_subnet.private_subnet.0.id] : null
  route_table_ids     = try(each.value.service_type, "Interface") == "Gateway" ? [aws_route_table.private.0.id] : null
  private_dns_enabled = try(each.value.service_type, "Interface") == "Interface" ? try(each.value.private_dns_enabled, null) : null

  tags = var.tags
}

# Security group
resource "aws_security_group" "this" {
  name   = "vpc-endpoint-ingress-sg"
  vpc_id = aws_vpc.main.id

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  security_group_id = aws_security_group.this.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = [var.main_vpc_cidr_block]
}