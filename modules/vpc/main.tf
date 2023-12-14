resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  
  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  
  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_internet_gateway" "main" {
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_nat_gateway" "nat-gateway" {
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws-route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private-route-table-association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private-route-table.id
}

