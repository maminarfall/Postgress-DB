variable "aws_region" {
  type    = string
  default = "us-east-2" # Good
}

variable "subnet_ids" { # good
  type    = list(string)
  default = ["subnet-0d62fa373035cfdcd"]
}

variable "max_connections" {
  description = "The maximum number of concurrent connections allowed to the database."
  type        = string
  default     = 100
} # Good

variable "shared_buffers" {
  description = "The amount of memory allocated to PostgreSQL for caching data."
  type        = string
  default     = "256MB" # Good
}

variable "postgresql_instance" {
  type = map(any)
  default = {
    identifier              = "my-postgresql-db"
    engine                  = "postgres"
    engine_version          = "13.2"
    instance_class          = "db.t2.micro"
    allocated_storage       = 20
    max_allocated_storage   = 100
    storage_type            = "gp2"
    storage_encrypted       = true
    publicly_accessible     = false
    multi_az                = false
    db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids  = [aws_security_group.db_security_group.id]
    db_parameter_group_name = aws_db_parameter_group.db_parameter_group.name
    username                = "db_user"
    password                = "db_password"
  }
}

