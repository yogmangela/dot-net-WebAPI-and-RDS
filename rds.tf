################################################################################
# RDS Module
################################################################################

resource "aws_db_instance" "webapi" {
  allocated_storage    = 10
  db_name              = var.app_name
  identifier           = "${var.app_name}-db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = aws_secretsmanager_secret_version.db-pass-val.secret_string
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = module.vpc.database_subnet_group
  depends_on           = [module.vpc]
  #   vpc_security_group_ids = [module.security_group.security_group_id]
  vpc_security_group_ids = [module.security_group.security_group_id]
  #["${var.vpc_security_group_ids}"]

  # multi_az = true # Enable RDS monitoring  
  # monitoring_interval = 5  # Enable RDS monitoring
}


# # Auto Scaling Configuration for WebAPI
# resource "aws_autoscaling_group" "webapi_asg" {
#   desired_capacity     = 2
#   max_size             = 4
#   min_size             = 2
#   vpc_zone_identifier  = [module.vpc.private_subnets.id]  
# }

  