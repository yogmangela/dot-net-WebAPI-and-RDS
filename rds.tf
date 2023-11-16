################################################################################
# RDS Module
################################################################################

resource "aws_db_instance" "webapi" {
  allocated_storage      = 10
  db_name                = var.app_name
  identifier             = "${var.app_name}-db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = aws_secretsmanager_secret_version.db-pass-val.secret_string
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]
  depends_on             = [module.vpc]
  # kms_key_id              = aws_kms_key.rds_kms_key.id
  backup_retention_period = 5
  multi_az                = true # Enable RDS monitoring  
  monitoring_interval     = 5    # Enable RDS monitoring
}

resource "aws_launch_template" "webapi_rds" {
  name_prefix   = "webapi"
  instance_type = "db.t3.micro"
}

# Auto Scaling Configuration for WebAPI
# resource "aws_autoscaling_group" "webapi_asg" {
#   desired_capacity    = 2
#   max_size            = 4
#   min_size            = 2
#   count               = length(module.vpc.private_subnets)
#   vpc_zone_identifier = flatten(module.vpc.private_subnets)[*].id

#   launch_template {
#     id      = aws_launch_template.webapi_rds.id
#     version = "$Latest"
#   }
# }

  