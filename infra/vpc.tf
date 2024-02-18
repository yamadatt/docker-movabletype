resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "yamada-ecs"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "yamada-ecs-public1-ap-northeast-1a"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "yamada-ecs-public2-ap-northeast-1c"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "yamada-ecs"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "yamada-ecs-rtb-public"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}



resource "aws_security_group" "alb_sg" {
  name        = "alb"
  description = "Allow http and https traffic."
  vpc_id      = aws_vpc.main.id
  # ここにingressを書かず、ルールはaws_security_group_ruleを使って定義する
}

# 80番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.alb_sg.id
}

# 443番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_https" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.alb_sg.id
}

# アウトバウンドのAll許可
resource "aws_security_group_rule" "outbound_any" {
  type      = "egress"
  protocol  = -1
  from_port = 0
  to_port   = 0
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.alb_sg.id
}








resource "aws_security_group" "contaner_sg" {
  name        = "contaner_sg"
  description = "Allow 8091 traffic."
  vpc_id      = aws_vpc.main.id
  # ここにingressを書かず、ルールはaws_security_group_ruleを使って定義する
}

# 80番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_80" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.contaner_sg.id
}

# 443番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_8091" {
  type      = "ingress"
  from_port = 8091
  to_port   = 8091
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.contaner_sg.id
}

# アウトバウンドのAll許可
resource "aws_security_group_rule" "outbound_egress" {
  type      = "egress"
  protocol  = -1
  from_port = 0
  to_port   = 0
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでweb_serverセキュリティグループに紐付け
  security_group_id = aws_security_group.contaner_sg.id
}