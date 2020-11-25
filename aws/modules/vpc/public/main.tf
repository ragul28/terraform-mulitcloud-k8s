##########################################################
# VPC architecture with Nat-gw
#   vpc------------------------------------------------
#   |  (public-subnet [worker]) }---{router}---{IGW}  |
#   ---------------------------------------------------
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

# Outputs
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}