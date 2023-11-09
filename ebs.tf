
# resource "aws_instance" "web" {
#   ami           = "ami-09abb6457c770f890"
#   instance_type = "t3.micro"

#   tags = {
#     Name = var.app_name
#   }
# }


# Elastic Beanstalk for .NET WebAPI
resource "aws_elastic_beanstalk_application" "webapi_app" {
  name        = var.app_name
  description = "WebServer to deploy .Net WebAPI"
}

resource "aws_elastic_beanstalk_environment" "webapi_env" {
  name                = "${var.app_name}-environment"
  application         = aws_elastic_beanstalk_application.webapi_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v3.0.0 running .NET 6"
  tier                = "WebServer"
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_ENDPOINT"
    value     = aws_db_instance.webapi.endpoint
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_NAME"
    value     = aws_db_instance.webapi.db_name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_USERNAME"
    value     = aws_db_instance.webapi.username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_PASSWORD"
    value     = aws_secretsmanager_secret_version.db-pass-val.secret_string
    # value = aws_db_instance.webapi.password

  }
}
