##########################################################
# VPC architecture with Nat-gw
#   vpc------------------------------------------------
#   |  (public-subnet  [nat-gw])                       |
#   |                     |^|    }---{router}---{IGW}  |
#   |  (private-subnet [worker])                       |
#   ----------------------------------------------------
##########################################################

# Create VPC 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
      name = var.project
      created =  "terraform"
  }
}

data "aws_availability_zones" "available" {}

# public subnet 
resource "aws_subnet" "public_subnet" {
  count = var.subnet_count

  # get /24 subnet from vpc using count
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    name = var.project
    created =  "terraform"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = var.project
    created =  "terraform"
  }
}

resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_public" {
  count = var.subnet_count

  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.route_public.id
}

# Nat gateway placed under public subnet to route to traffic to igw
resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw_public" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet.1.id
}

# private subnet 
resource "aws_subnet" "private_subnet" {
  count = var.subnet_count

  # get /24 subnet from vpc using count
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + var.subnet_count)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    name = var.project
    created =  "terraform"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "route_private" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat_gw_public.id
  }

  tags = {
    name = var.project
    created =  "terraform"
  }
}

resource "aws_route_table_association" "rta_private" {
  count = var.subnet_count

  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_route_table.route_private.id
}

# Outputs
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "pvt_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}