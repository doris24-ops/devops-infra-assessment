data "aws_availability_zones" "available" {
  state = "available"
}
locals {
  resource_name = "${var.project_name}-${var.environment_name}"
}
# Create VPC
resource "aws_vpc" "vpc" {

  cidr_block = var.vpc_cidr_block
  tags = tomap({
    "Name"                                                 = "${local.resource_name}-vpc"
    "kubernetes.io/cluster/${local.resource_name}-cluster" = "shared"

    "Environment" = "${var.environment_name}"
  })
}

# Create public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name                                                   = "${local.resource_name}-public-subnet${count.index + 1}"
    Environment                                            = "${var.environment_name}"
    "kubernetes.io/cluster/${local.resource_name}-cluster" = "shared"
    "kubernetes.io/role/elb"                               = "1"
  }
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name                                                   = "${local.resource_name}-private-subnet${count.index + 1}"
    Environment                                            = "${var.environment_name}"
    "kubernetes.io/cluster/${local.resource_name}-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                      = "1"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.resource_name}-igw"
  }
}

# Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${local.resource_name}-public-route-table"
    Environment = "${var.environment_name}"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Allocate Elastic IP for NAT gateway
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "${local.resource_name}-elastic-ip"
  }
}
# Create NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id # Choose one of the public subnets

  tags = {
    Name = "${local.resource_name}-ngw"
  }
}

# Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${local.resource_name}}-private-route-table"
    Environment = "${var.environment_name}"
  }
}

# Create route from private subnets to NAT gateway
resource "aws_route" "private_subnet_route" {
  #count                  = length(aws_subnet.private_subnets)
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
# Associate private subnets with the private route table
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
  depends_on     = [aws_route_table.private_route_table, aws_subnet.private_subnets]
}




