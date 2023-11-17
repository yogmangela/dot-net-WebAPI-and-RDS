# Elastic Beanstalk for .NET WebAPI
resource "aws_elastic_beanstalk_application" "webapi_app" {
  name        = var.app_name
  description = "WebServer to deploy .Net WebAPI"
}

################################################################################
# Step 1: Configure environment
################################################################################

resource "aws_elastic_beanstalk_environment" "webapi_env" {
  name                   = "${var.app_name}-environment"
  application            = aws_elastic_beanstalk_application.webapi_app.name
  solution_stack_name    = var.ebs_stack_name
  tier                   = var.tier
  wait_for_ready_timeout = "20m"

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  ################################################################################
  # Step 2: Configure service access
  ################################################################################

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.EC2KeyName
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = var.Env_type
  }
  ################################################################################
  # Step 3: Set up networking, database, and tags
  ################################################################################
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = flatten(module.vpc.public_subnets)[0]
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
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_ENDPOINT"
    value     = aws_db_instance.webapi.endpoint
  }
  ################################################################################
  # Step 4: Configure instance traffic and scaling
  ################################################################################
  # setting {
  #   namespace = "aws:ec"
  #   name      = "InstanceName"
  #   value     = "ami-0df034e631b8a333b"
  # }
  # setting {
  #   namespace = "aws:autoscaling:launchconfiguration"
  #   name      = "IamInstanceProfile"
  #   value     = aws_iam_instance_profile.webapi_instance_profile.id
  # }

  # setting {
  #   namespace = "aws:autoscaling:launchconfiguration"
  #   name      = "InstanceType"
  #   value     = var.instance_type
  # }

  # setting {
  #   namespace = "aws:autoscaling:asg"
  #   name      = "MinSize"
  #   value     = 1
  # }
  # setting {
  #   namespace = "aws:autoscaling:asg"
  #   name      = "MaxSize"
  #   value     = 2
  # }
  ################################################################################
  # Step 5: Configure updates, monitoring, and logging
  ################################################################################
  # setting {
  #   namespace = "aws:elasticbeanstalk:environment:process:default"
  #   name      = "MatcherHTTPCode"
  #   value     = "200"
  # }

  # setting {
  #   namespace = "aws:elasticbeanstalk:healthreporting:system"
  #   name      = "SystemType"
  #   value     = "enhanced"
  # }

  # Enable cloudwatch Logs for Elastic Beanstalk
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }
  depends_on = [aws_db_instance.webapi]
}



