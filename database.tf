#DB SUBNET GROUP#

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "project-db-subnet-group"
  subnet_ids = [aws_subnet.db_a.id, aws_subnet.db_b.id]

  tags = {
    Name = "project-db-subnet-group"
  }
}

#Amazon RDS MySQL Instance#

resource "aws_db_instance" "mysql_db" {
  identifier             = "project-mysql-db"
  allocated_storage      = var.db_allocated_storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = false

  tags = {
    Name = "project-mysql-db"
  }

}
