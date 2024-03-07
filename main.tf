provider "aws" {
  region = var.aws_region
}

# Create a security group for the RDS instance
resource "aws_security_group" "db_security_group" {
  name        = var.db_security_group_name
  description = "Security group for PostgreSQL RDS instance"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group rule for ingress (allowing incoming connections)
resource "aws_security_group_rule" "db_ingress_rule" {
  security_group_id = aws_security_group.db_security_group.id

  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Create a security group rule for egress (allowing outgoing connections)
resource "aws_security_group_rule" "db_egress_rule" {
  security_group_id = aws_security_group.db_security_group.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Create a subnet group for the RDS instance
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
}

# Create a parameter group for the RDS instance
resource "aws_db_parameter_group" "db_parameter_group" {
  name        = var.db_parameter_group_name
  family      = "postgres"
  description = "Custom parameter group for PostgreSQL RDS instance"

  parameter {
    name  = "max_connections"
    value = var.max_connections
  }

  parameter {
    name  = "shared_buffers"
    value = var.shared_buffers
  }
}

# Create the PostgreSQL RDS instance
resource "aws_db_instance" "postgresql_instance" {
  identifier              = var.postgresql_instance["identifier"]
  engine                  = var.postgresql_instance["engine"]
  engine_version          = var.postgresql_instance["engine_version"]
  instance_class          = var.postgresql_instance["instance_class"]
  allocated_storage       = var.postgresql_instance["allocated_storage"]
  max_allocated_storage   = var.postgresql_instance["max_allocated_storage"]
  storage_type            = var.postgresql_instance["storage_type"]
  storage_encrypted       = var.postgresql_instance["storage_encrypted"]
  publicly_accessible     = var.postgresql_instance["publicly_accessible"]
  multi_az                = var.postgresql_instance["multi_az"]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  db_parameter_group_name = aws_db_parameter_group.db_parameter_group.name
  username                = var.postgresql_instance["username"]
  password                = var.postgresql_instance["password"]
}
