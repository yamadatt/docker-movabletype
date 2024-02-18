terraform {
  required_version = "~> 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
  }
}


module "network" {
  source   = "../../modules/network"
  env      = local.env
  network  = local.network

}

module "db" {
  source   = "../../modules/db"
  env      = local.env
  db       = local.db
  network  = module.network
  ars_list = local.ars_ap
}


