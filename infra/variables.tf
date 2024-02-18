locals {
  env = "poc"
  db = {
    engine            = "mysql"
    version           = "5.7"
    instance_class    = "db.t3.micro"
    allocated_storage = "20"
    storage_type      = "gp2"
    db_name           = "movabletype"
    username          = "movabletype"
    password          = "movabletype"
  }

}


