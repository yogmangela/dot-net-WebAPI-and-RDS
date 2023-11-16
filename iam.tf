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


# IAM for codebuilder 

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "build" {
  name               = "dot-net-build"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "build" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    resources = ["arn:aws:ec2:eu-west-1:${var.AWS_ACCOUNT}:network-interface/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:Subnet"

      values = [
        "module.vpc.public_subnets.*.arn"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "aws_s3_bucket.codebuild",
      "${aws_s3_bucket.codebuild.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "build_policy" {
  role   = aws_iam_role.codebuild.arn
  policy = data.aws_iam_policy_document.build.json
}
