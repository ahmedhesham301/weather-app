# Private subnets
resource "aws_subnet" "private" {
  for_each = {
    for i, az in data.aws_availability_zones.available.names :
    az => i
  }

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value)
  availability_zone = each.key
  tags = {
    Name = "private-${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[each.key].id
  }
  tags = {
    "Name" = "rt-private-${each.key}"
  }
}


resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}


#public subnets
resource "aws_subnet" "public" {
  for_each = {
    for i, az in data.aws_availability_zones.available.names :
    az => i
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value + length(data.aws_availability_zones.available.names))
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = {
    Name = "public-${each.key}"
  }
}

resource "aws_route_table" "public" {
  for_each = aws_subnet.public
  vpc_id   = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    "Name" = "rt-public-${each.key}"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}
resource "aws_nat_gateway" "ngw" {
  for_each      = aws_subnet.public
  subnet_id     = each.value.id
  allocation_id = aws_eip.ngw[each.key].id
  tags = {
    "Name" = "ngw-${each.key}"
  }

}

resource "aws_eip" "ngw" {
  for_each = aws_subnet.public
  domain   = "vpc"
  tags = {
    "Name" = "eip-ngw-${each.key}"
  }
}