locals {
  env = "stag"
  network = {
    cider_vpc       = "10.1.0.0/16"
    cider_subnet_1a = "10.1.1.0/24"
    cider_subnet_1c = "10.1.2.0/24"
  }
  db = {
    engine            = "postgres"
    version           = "12.14"
    instance_class    = "db.t3.micro"
    allocated_storage = "20"
    storage_type      = "gp2"
    db_name           = "staging"
    username          = "staginguser"
    password          = "stagingpass"
  }

}


