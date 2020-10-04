##########################################################
# VPC architecture
#   vpc------------------------------------------------
#   |  (public-subnet  [nat-gw])                       |
#   |                     |^|    }---{router}---{IGW}  |
#   |  (private-subnet [worker])                       |
#   ----------------------------------------------------
##########################################################

# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
      name = var.project
      created =  "terraform"
  }
}

data "aws_availability_zones" "available" {}

# public subnet 
resource "aws_subnet" "eks_public_subnet" {
  count = var.subnet_count

  # get /24 subnet from vpc using count
  cidr_block              = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.eks_vpc.id

  tags = {
    name = var.project
    created =  "terraform"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    name = var.project
    created =  "terraform"
  }
}

resource "aws_route_table" "eks_route_public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
}

resource "aws_route_table_association" "eks_rta_public" {
  count = 3

  subnet_id      = aws_subnet.eks_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.eks_route_public.id
}

# Nat gateway placed under public subnet to route to traffic to igw
resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw_public" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.eks_public_subnet.1.id
}

# private subnet 
resource "aws_subnet" "eks_private_subnet" {
  count = var.subnet_count

  # get /24 subnet from vpc using count
  cidr_block              = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index + var.subnet_count)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.eks_vpc.id

  tags = {
    name = var.project
    created =  "terraform"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "eks_route_private" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat_gw_public.id
  }

  tags = {
    name = var.project
    created =  "terraform"
  }
}

resource "aws_route_table_association" "eks_rta_private" {
  count = 3

  subnet_id      = aws_subnet.eks_private_subnet.*.id[count.index]
  route_table_id = aws_route_table.eks_route_private.id
}

output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.eks_private_subnet.*.id
}