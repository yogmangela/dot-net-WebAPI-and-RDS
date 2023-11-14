
# Output the RDS endpoint for reference
output "rds_endpoint" {
  value = aws_db_instance.webapi.endpoint
}

output "webapi_endpoint" {
  value = aws_elastic_beanstalk_environment.webapi_env.endpoint_url
}

output "dotNet_VPC_id" {
  value = module.vpc.default_vpc_id
}

output "rds_address" {
  value = aws_db_instance.webapi.address
}