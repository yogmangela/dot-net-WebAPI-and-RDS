resource "random_password" "db_master_pass" {
  length           = 10
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
  keepers = {
    pass_version = 1
  }
}


resource "aws_secretsmanager_secret" "db-pass" {
  name = "DotNet-WebAPI-db-pass"
}

resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id     = aws_secretsmanager_secret.db-pass.id
  secret_string = random_password.db_master_pass.result
}