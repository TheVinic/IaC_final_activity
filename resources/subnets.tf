resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "public" {

  count             = var.subnet_public_quantity
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, local.size_subnets, count.index + 1)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${terraform.workspace} public subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private" {

  count             = var.subnet_private_amount
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, local.size_subnets, count.index + var.subnet_public_quantity + 1)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${terraform.workspace} private subnet ${count.index + 1}"
  }
}

resource "aws_route_table_association" "public" {
  count = var.subnet_public_quantity

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = var.subnet_private_amount

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}