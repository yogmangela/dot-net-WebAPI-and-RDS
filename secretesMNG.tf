resource "random_password" "db_master_pass" {
  length           = 10
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
  keepers = {
    pass_version = 1
  }

}

resource "aws_secretsmanager_secret" "db-secrete" {
  name                    = "${var.app_name}-db-secrete"
  recovery_window_in_days = 0 # make sure to change this value when depoyong for prod
}

resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id     = aws_secretsmanager_secret.db-secrete.id
  secret_string = random_password.db_master_pass.result
}
