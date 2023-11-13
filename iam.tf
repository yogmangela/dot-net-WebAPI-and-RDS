# IAM Role for Elastic Beanstalk
resource "aws_iam_role" "webapi_instance_role" {
  name = "webapi-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "webapi_instance_profile" {
  name = "webapi-instance-profile"

  role = aws_iam_role.webapi_instance_role.name
}


# IAM Role Policies for WebAPI Instances
resource "aws_iam_role_policy_attachment" "webapi_ec2_permissions" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = aws_iam_role.webapi_instance_role.name
}

resource "aws_iam_role_policy_attachment" "webapi_s3_permissions" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.webapi_instance_role.name
}


