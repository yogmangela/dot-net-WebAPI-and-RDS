
# Output the RDS endpoint for reference
output "rds_endpoint" {
  value = aws_db_instance.webapi.endpoint
}