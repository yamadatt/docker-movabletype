provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      resoruce = "terraform"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


module "db" {
  source              = "./modules/db"
  env                 = local.env
  db                  = local.db
  vpc-id              = aws_vpc.main.id
  subnet-public-1a-id = aws_subnet.public1.id
  subnet-public-1c-id = aws_subnet.public2.id
}

output "db_host" {
  value = module.db.db_host
}