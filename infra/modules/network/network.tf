  # --------------------------------
#  network
# --------------------------------

# --------------------------------
#  input prameter
variable env {
  type = string
}
variable network {
  type = object({
    cider_vpc       = string
    cider_subnet_1a = string
    cider_subnet_1c = string
  })
}


# vpc
resource "aws_vpc" "vpc" {
    cidr_block = var.network.cider_vpc 
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
      Name = "${var.env}-vpc"
    }
}


# subnet
## public
resource "aws_subnet" "public-1a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = var.network.cider_subnet_1a 
    availability_zone = "ap-northeast-1a"
    tags = {
      Name = "${var.env}-public-1a"
    }
}

resource "aws_subnet" "public-1c" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = var.network.cider_subnet_1c
    availability_zone = "ap-northeast-1c"
    tags = {
      Name = "${var.env}-public-1c"
    }
}


# route table
resource "aws_route_table" "public-route" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc-gw.id}"
    }
    tags = {
      Name = "${var.env}-public-route"
    }
}

resource "aws_route_table_association" "public-a" {
    subnet_id = "${aws_subnet.public-1a.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}

resource "aws_route_table_association" "public-c" {
    subnet_id = "${aws_subnet.public-1c.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}

# internet gateway
resource "aws_internet_gateway" "vpc-gw" {
    vpc_id = "${aws_vpc.vpc.id}"
    depends_on = [aws_vpc.vpc]
    tags = {
      Name = "${var.env}-vpc-gw"
    }
}



# --------------------------------
#  output
output "vpc-id" {
  value = aws_vpc.vpc.id
}
# output "route_table" {
#   value = aws_route_table.public-route
# }

output "subnet-public-1a-id" {
  value = aws_subnet.public-1a.id
}

output "subnet-public-1c-id" {
  value = aws_subnet.public-1c.id
}