resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project-vpc"
  }

}

#PUBLIC SUBNETS#

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-b"
  }
}

#PRIVATE SUBNETS#

resource "aws_subnet" "pvt_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "pvt-subnet-a"
  }
}

resource "aws_subnet" "pvt_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "pvt-subnet-b"
  }
}

#DB SUBNETS#

resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "db-subnet-a"
  }
}

resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "db-subnet-b"
  }
}

#INTERNET GATEWAY#

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project-igw"
  }
}

#ROUTE TABLE#

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_assoc" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

#PRIVATE ROUTE TABLE#
resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

#PRIVATE ROUTE TABLE ASSOCIATIONS# 
resource "aws_route_table_association" "private_a_assoc" {
  subnet_id      = aws_subnet.pvt_a.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_b_assoc" {
  subnet_id      = aws_subnet.pvt_b.id
  route_table_id = aws_route_table.private_rt.id
}


#ELASTIC IP FOR NAT GATEWAY#

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

#NAT GATEWAY#

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id


  tags = {
    Name = "nat-gateway"
  }
}
