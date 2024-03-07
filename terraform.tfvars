aws_region = "us-east-2"

subnet_ids = ["subnet-0d62fa373035cfdcd"]

max_connections = "100"

shared_buffers = "256MB"

postgresql_instance = {
  identifier            = "my-postgresql-db"
  engine                = "postgres"
  engine_version        = "13.2"
  instance_class        = "db.t2.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = true
  publicly_accessible   = false
  multi_az              = false
  # Assuming these values are dynamic and will be filled in during runtime
  db_subnet_group_name    = ""
  vpc_security_group_ids  = []
  db_parameter_group_name = ""
  username                = "db_user"
  password                = "db_password"
}


