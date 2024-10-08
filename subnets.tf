resource "aws_subnet" "private-eu-central-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    "Name"                                      = "private-eu-central-1a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private-eu-central-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    "Name"                                      = "private-eu-central-1b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private-eu-central-1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    "Name"                                      = "private-eu-central-1c"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public-eu-central-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.30.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-eu-central-1a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public-eu-central-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.40.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-eu-central-1b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public-eu-central-1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.50.0/24"
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-eu-central-1c"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

