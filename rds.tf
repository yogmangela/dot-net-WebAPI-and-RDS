################################################################################
# RDS Module
################################################################################

resource "aws_db_instance" "webapi" {
  allocated_storage    = 10
  db_name              = "${var.app_name}-db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = aws_secretsmanager_secret_version.db-pass-val.secret_string
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = module.vpc.database_subnet_group
}