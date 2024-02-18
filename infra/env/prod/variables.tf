locals {
  env = "prod"
  network = {
    cider_vpc       = "10.2.0.0/16"
    cider_subnet_1a = "10.2.1.0/24"
    cider_subnet_1c = "10.2.2.0/24"
  }
  db = {
    engine            = "postgres"
    version           = "12.14"
    instance_class    = "db.t3.medium"
    allocated_storage = "20"
    storage_type      = "gp2"
    db_name           = "production"
    username          = "prouser"
    password          = "prodpass"
  }


}


