# Create a security group for the RDS instance
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = var.app_name
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

}

# Security Group Rules for RDS
resource "aws_security_group" "webapi_sg" {
  name        = "webapi-sg"
  description = "Security Group for WebAPI"
}

# resource "aws_security_group_rule" "webapi_sg_ingress" {
#   security_group_id        = aws_security_group.webapi_sg.id
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   source_security_group_id = aws_elastic_beanstalk_environment.webapi_env.security_group_id
# }

# # RDS Security Group Rules
# resource "aws_security_group_rule" "rds_sg_ingress" {
#   security_group_id        = [aws_db_instance.webapi.vpc_security_group_ids] # "${aws_instance.ec2[*].id}"
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.webapi_sg.id
# }